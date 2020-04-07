using SimpleEcs;
using System;
using System.Collections.Generic;
using System.Linq;

public class BasicEcs
{

    private Dictionary<string, AbstractSystem> systems = new Dictionary<string, AbstractSystem>();
    public List<AbstractEntity> entities = new List<AbstractEntity>(); // todo - use dictionary with entity id
    private IEcsEventListener eventListener;

    public BasicEcs(IEcsEventListener _eventListener)
    {
        this.eventListener = _eventListener;

    }


    public void AddSystem(AbstractSystem system)
    {
        this.systems.Add(system.GetName(), system);
    }



    public AbstractSystem GetSystem(string name)
    {
        return this.systems[name];
    }


    // Call this at the start of any game loop iteration
    public void Process()
    {
        // Remove any entities
        for (int i = this.entities.Count - 1; i >= 0; i--)
        {
            var entity = this.entities[i];
            if (entity.markForRemoval)
            {
                this.entities.Remove(entity);
                this.eventListener.EntityRemoved(entity);
            }
        }

    }


    public void RemoveAllEntities()
    {
        while (this.entities.Count > 0)
        {
            var entity = this.entities[0];
            this.entities.Remove(entity);
            this.eventListener.EntityRemoved(entity);
        }
    }

}
