
using System;
using System.Collections.Generic;

public class AbstractEntity {

	private static int next_id = 0;

	private BasicEcs ecs;

	public int entityId;
	public string name;
	private Dictionary<Type, object> components = new Dictionary<Type, object>();
	private Dictionary<Type, object> hiddenComponents = new Dictionary<Type, object>(); // For temporarily removing components, e.g. collision
	private bool markForRemoval = false;
	
	public AbstractEntity(BasicEcs _ecs, string _name) {
		ecs = _ecs;
		this.entityId = next_id++;
		this.name = _name;
	}


	public void addComponent(object component) {
		this.components.Add(component.GetType(), component);
		if (this.ecs.containsEntity(this)) { // Don't add to system if entity hasn't been added to main list yet
			ecs.addEntityToSystems(this, component.GetType());
		}
	}


	public void removeComponent(Type clazz) {
		this.components.Remove(clazz);
		ecs.removeEntityFromSystems(this, clazz);
	}


	public void hideComponent(Type clazz) {
		object component = this.components.Remove(clazz);
		this.hiddenComponents.Add(clazz, component);
		ecs.removeEntityFromSystems(this, clazz);
	}


	public void restoreComponent(Type clazz) {
		Object component = this.hiddenComponents.Remove(clazz);
		if (component != null) { // Just in case the component doesn't exist
			this.components.Add(clazz, component);
			ecs.addEntityToSystems(this, clazz);
		}
	}


	public object getComponent(Type name) {
		if (this.components.ContainsKey(name)) {
			return this.components[name];
		} else {
			return null;
		}
	}


	public Dictionary<Type, object> getComponents() {
		return this.components;
	}


	public bool isMarkedForRemoval() {
		return this.markForRemoval;
	}


	public void remove() {
		this.markForRemoval = true;
	}


	public void unmarkForRemoval() {
		this.markForRemoval = false;
	}


	public virtual string toString() {
		return name;
	}

}
