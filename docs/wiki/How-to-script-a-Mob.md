## Intro

Every entity in the game is controlled by a `Controller`.

Mobs are controlled by `MobController` ([link](https://github.com/LandSandBoat/server/blob/release/src/map/ai/controllers/mob_controller.cpp)).

The controller is `Ticked` every 400ms. This tick executes the Mob's AI routine. This includes spawning, despawning, casting, targetting, auto-attacks, weaponskills, combat logic, roaming logic, detection/aggro, linking and all other things it is that Mobs do.

Most of these functions are tied to a Lua binding. If a Mob has an entry in their script that corresponds to that binding; it will be executed.

# Lua Functions

The following functions can be placed in a Mob's script file to attach functionality to them.

```lua
local entity = {}

-- When the mob is initialized for the first time
-- (seperate from spawning and despawning) 
entity.onMobInitialize = function(mob)
end

-- When the Mob spawns
entity.onMobSpawn = function(mob)
end

-- When a Mob despawns
entity.onMobDespawn = function(mob)
end

-- When a Mob engages in combat
entity.onMobEngaged = function(mob, target)
end

-- When a Mob disengages from combat
entity.onMobDisengage = function(mob)
end

-- Every 400ms while in combat
entity.onMobFight = function(mob, target)
end

-- Every 400ms while not in combat
entity.onMobRoam = function(mob)
end

-- Just before the Mob casts a spell
entity.onSpellPrecast = function(mob, spell)
end

-- When the Mob is hit by a spell
entity.onMagicHit = function(caster, target, spell)
end

-- When the Mob IS HIT by a critical hit
entity.onCriticalHit = function(mob, attacker)
end

-- When a Mob dies
-- NOTE: Called once for every member of the killing alliance
entity.onMobDeath = function(mob, player, optParams)
end

-- When a Mob despawns
entity.onMobDespawn = function(mob)
end

return entity
```

## LocalVars

The lifeblood of keeping state on your Mob. They have next to zero performance cost. These are great for maintaining information you need for your mob to operate, for the lifetime of this specific mob. **THEY ARE RESET ON SPAWN**

```lua
-- An undefined localVar will return 0
local counter = mob:getLocalVar("counter")
-- counter == 0

-- Set a localVar
mob:setLocalVar("counter", 1)
-- counter == 1

-- Increment a localVar
mob:setLocalVar("counter", mob:getLocalVar("counter) + 1)
```

## Listeners
`TODO`

Listeners can be attached or removed from entities at runtime to fire callbacks based on certain triggering conditions. They cover everything that's covered by regular Lua functions, but also have a lot finer-grained options available.

`mixins` are all based around listeners, highly recommended you look at them for guidance.

```lua
-- Syntax
mob:addListener("LISTENER_NAME", "UNIQUE_IDENTIFIER", function(mob) end)

mob:removeListener("UNIQUE_IDENTIFIER")

---

mob:addListener("SPAWN", "SPAWN_IDENTIFIER_STRING", function(mob)
    print("I have spawned!")
    mob:useMobAbility(1)
end)

mob:addListener("TAKE_DAMAGE", "TAKE_DAMAGE_IDENTIFIER_STRING", function(mob, amount, attacker, attackType, damageType)
end

-- Fire the first time the mob takes damage, then remove the listener
mob:addListener("TAKE_DAMAGE", "TAKE_DAMAGE_IDENTIFIER_STRING", function(mob, amount, attacker, attackType, damageType)
    << REACT IN SOME WAY >>
    mob:removeListener("TAKE_DAMAGE_IDENTIFIER_STRING")
end

-- and many others...
```

## Working with 400ms ticks
If you want to fire a piece of logic _once_ from within a 400ms tick, you'll need to gate it behind a localVar.
```lua
entity.onMobFight = function(mob, target)
    local hasDoneSpecialMove = mob:getLocalVar("hasDoneSpecialMove") -- Defaults to zero
    
    if hasDoneSpecialMove == 0 then -- Only come in here if hasDoneSpecialMove is zero
        << DO MAGIC SUPER MOVE HERE >>

        mob:setLocalVar("hasDoneSpecialMove", 1) -- Setting this to 1 means this block can't be entered again
    end
end
```

## Queueing Actions
Core exposes `timer` and `queue` functions for all entities, allowing you to create chains of functions however you see fit.
```lua
-- Syntax:
-- Timer will fire as soon as possible after the wait has elapsed
-- entity:timer(time_in_milliseconds, function_to_be_called)

-- Queue will fire as soon as the mob is in a free state after the wait has elapsed
-- entity:queue(time_in_milliseconds, function_to_be_called)

mob:timer(1000, function(mob) print("One second has passed!") end)

mob:queue(1000, function(mob) mob:useMobAbility(1) end)
```
