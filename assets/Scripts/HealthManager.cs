using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthManager
{
    private float health;

    public HealthManager(float health)
    {
        this.health = health;
    }

    public float GetHealth()
    {
        return health;
    }

    public void ChangeHealth(float health)
    {
        this.health = health;
    }

    public void TakeDamage(float damage, Action action)
    {
        health -= damage;
        if (health <= 0)
        {
            action.Invoke();
        }
    }

    public void AddHealth(float health)
    {
        this.health += health;
    }
}
