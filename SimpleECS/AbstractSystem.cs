using System.Collections.Generic;

public abstract class AbstractSystem
{

    protected BasicEcs ecs;

    public AbstractSystem(BasicEcs _ecs)
    {
        this.ecs = _ecs;

        this.ecs.AddSystem(this);

    }



    public string GetName()
    {
        return this.GetType().ToString();
    }


    // Override if required to run against all entities
    public virtual void Process()
    {
        foreach (AbstractEntity entity in this.ecs.entities)
        {
            this.ProcessEntity(entity);
        }
    }


    public virtual void ProcessEntity(AbstractEntity entity)
    {
        // Override if required to run against a single entity.
    }


}
