
using System;
using System.Collections.Generic;

public class BasicEcs
{

    private Dictionary<Type, ISystem> systems = new Dictionary<Type, ISystem>();
    private List<AbstractEntity> entities = new List<AbstractEntity>();
    private List<AbstractEntity> to_add_entities = new List<AbstractEntity>();
    public List<AbstractEvent> events = new List<AbstractEvent>(); // todo - make private, add an add()

    public BasicEcs()
    {
    }


    public void addSystem(ISystem system)
    {
        this.systems.Add(system.GetType(), system);
    }


    public void removeSystem(Type clazz)
    {
        this.systems.Remove(clazz);
    }


    public ISystem getSystem(Type clazz)
    {
        return this.systems[clazz];
    }


    public void processSystem(Type clazz)
    {
        ISystem system = this.getSystem(clazz);
        if (system != null)
        {
            system.process();
        }
    }


    /**
	 * Do not call this directly.  It will be called automatically by AbstractEntity.
	 */
    public void addEntityToSystems(AbstractEntity e, Type component_class)
    {
        // Add to appropriate systems
        foreach (ISystem isystem in this.systems.Values)
        {
            if (isystem.GetType() == typeof(AbstractSystem))
            {
                AbstractSystem system = (AbstractSystem)isystem;
                Type system_clazz = system.getComponentClass();
                if (system_clazz != null)
                {
                    if (component_class == system_clazz)
                    {
                        system.addEntity(e);
                    }
                }
            }
        }
    }


    /**
     * Do not call this directly.  It will be called automatically by AbstractEntity.
     */
    public void removeEntityFromSystems(AbstractEntity e, Type component_class)
    {
        // Remove from appropriate systems
        foreach (ISystem isystem in this.systems.Values)
        {
            if (isystem.GetType() == typeof(AbstractSystem))
            {
                AbstractSystem system = (AbstractSystem)isystem;
                Type system_clazz = system.getComponentClass();
                if (system_clazz != null)
                {
                    if (component_class == system_clazz)
                    {
                        system.entities.Remove(e);
                    }
                }
            }
        }
    }


    /**
	 * Call this in your main loop to avoid concurrency errors.
	 */
    public void addAndRemoveEntities()
    {
        // Remove any entities
        for (int i = this.entities.Count - 1; i >= 0; i--)
        {
            AbstractEntity entity = this.entities[i];
            if (entity.isMarkedForRemoval())
            {
                this.entities.Remove(entity);

                // Remove from systems
                foreach (ISystem isystem in this.systems.Values)
                {
                    if (isystem.GetType() == typeof(AbstractSystem))
                    {
                        AbstractSystem system = (AbstractSystem)isystem;
                        Type clazz = system.getComponentClass();
                        if (clazz != null)
                        {
                            if (entity.getComponents().ContainsKey(clazz))
                            {
                                system.entities.Remove(entity);
                            }
                        }
                    }
                }
            }
        }

        foreach (AbstractEntity e in this.to_add_entities)
        {
            foreach (ISystem isystem in this.systems.Values)
            {
                if (isystem.GetType() == typeof(AbstractSystem))
                {
                    AbstractSystem system = (AbstractSystem)isystem;
                    Type clazz = system.getComponentClass();
                    if (clazz != null)
                    {
                        if (e.getComponents().ContainsKey(clazz))
                        {
                            system.addEntity(e);
                        }
                    }
                }
            }
            this.entities.Add(e);
        }

        to_add_entities.Clear();
    }


    public void addEntity(AbstractEntity e)
    {
        e.unmarkForRemoval(); // In case it's been re-added after being removed
        this.to_add_entities.Add(e);
    }


    public void removeEntity(AbstractEntity e)
    {
        e.remove();
    }


    public AbstractEntity get(int i)
    {
        return this.entities[i];
    }


    public IEnumerator<AbstractEntity> getEntityIterator()
    {
        return this.entities.GetEnumerator();
    }


    public List<AbstractEvent> getEvents(Type clazz)
    {
        List<AbstractEvent> list = new List<AbstractEvent>();
        IEnumerator<AbstractEvent> it = this.events.GetEnumerator();
        while (it.MoveNext())
        {
            AbstractEvent evt = it.Current;
            if (evt.GetType() == clazz)
            {
                list.Add(evt);
            }
        }
        return list;
    }


    public List<AbstractEvent> getEventsForEntity(Type clazz, AbstractEntity e)
    {
        List<AbstractEvent> list = new List<AbstractEvent>();
        IEnumerator<AbstractEvent> it = this.events.GetEnumerator();
        while (it.MoveNext())
        {
            AbstractEvent evt = it.Current;
            if (evt.GetType() == clazz)
            {
                if (evt.isForEntity(e))
                {
                    list.Add(evt);
                }
            }
        }
        return list;
    }


    public void removeAllEntities()
    {
        foreach (AbstractEntity e in this.entities)
        {
            e.remove();
        }
        this.to_add_entities.Clear();
    }


    public bool containsEntity(AbstractEntity e)
    {
        return this.entities.Contains(e);
    }

}
