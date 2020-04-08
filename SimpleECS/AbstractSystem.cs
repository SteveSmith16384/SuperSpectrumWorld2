
using System;
using System.Collections.Generic;

public abstract class AbstractSystem : ISystem {

	protected BasicEcs ecs;
	public List<AbstractEntity> entities;
	private string name;
	protected Type component_class;

	public AbstractSystem(BasicEcs _ecs) : this(_ecs, null) { 
	}
	
	
	/**
	 * 
	 * @param _ecs
	 * @param _component_class The component that this system is interested in.
	 */
	public AbstractSystem(BasicEcs _ecs, Type _component_class) {
		this.ecs = _ecs;
		component_class = _component_class;
		
		name = this.GetType().Name;

		this.ecs.addSystem(this);

		if (this.getComponentClass() != null) {
			entities = new List<AbstractEntity>();
		}
	}


	/**
	 * Note to future self: Do NOT change this to handle multiple component types.  If that is
	 * needed, create a separate system!
	 */
	public Type getComponentClass() { // todo - make final when sure it works
		return component_class;
	}


	public String getName() {
		return this.GetType().Name;
	}

	
	public void addEntity(AbstractEntity e) {
		if (entities.Contains(e) == false) {
			entities.Add(e);
		} else {
			//throw new RuntimeException("Entity " + e + " already exists in " + this.name);
		}

	}


	public void process() {
		if (this.entities == null) {
			var it = ecs.getEntityIterator();
			while (it.MoveNext()) {
				AbstractEntity entity = it.Current;
				if (entity.isMarkedForRemoval()) {
					continue;
				}
				this.processEntity(entity);
			}
		} else {
			var it = entities.GetEnumerator();
			while (it.MoveNext()) {
				AbstractEntity entity = it.Current;
				if (entity.isMarkedForRemoval()) {
					continue;
				}
				this.processEntity(entity);
			}
		}
	}


	public void processEntity(AbstractEntity entity) {
	}

	
	public String toString() {
		return name;
	}
	
}
