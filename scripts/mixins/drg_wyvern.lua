-----------------------------------
-- Mixin for DRG beastmen that summon a wyvern pet (Mamool Ja Pikeman/Spearman, DRG-type Draugar).
--
-- Retail captures show these mobs essentially use Call Wyvern just like players do: whenever their
-- wyvern is gone and the same 20 minute recast is up, they resummon it the second the timer expires,
-- whether they are roaming or engaged. This is not their two hour. There is no ability message
-- either. Captures only show the Summoner cast animation (casm -> shsm), the same one the gigas
-- BST mixin uses. The wyvern persists if its owner dies.
--
-- The wyvern has to be linked with xi.pet.setMobPet in the mob script's onMobInitialize for this
-- mixin to do anything.
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------
g_mixins = g_mixins or {}
-----------------------------------

local callPetParams =
{
    inactiveTime = 1500, -- Plays the retail Summoner cast. casm -> shsm is about a second apart in captures.
}

local trySummon = function(mob)
    -- Never interrupt an in-progress action (callPets also stuns the owner during the cast).
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    local pet = mob:getPet()
    if not pet or pet:isSpawned() then
        return
    end

    if GetSystemTime() < mob:getLocalVar('[Pet]Recast') then
        return
    end

    if xi.mob.callPets(mob, nil, callPetParams) then
        -- Same 20 minute recast players get on Call Wyvern, counted from the summon.
        -- The wyvern dying or despawning later does not touch this timer.
        mob:setLocalVar('[Pet]Recast', GetSystemTime() + 1200)
    end
end

g_mixins.drg_wyvern = function(mob)
    mob:addListener('SPAWN', 'DRG_WYVERN_SPAWN', function(mobArg)
        -- Recast starts clear, so a fresh spawn calls its wyvern on its first roam tick.
        mobArg:setLocalVar('[Pet]Recast', 0)
    end)

    -- Both listeners on purpose: retail resummons mid-combat too, not just while roaming.
    mob:addListener('ROAM_TICK', 'DRG_WYVERN_ROAM_TICK', trySummon)
    mob:addListener('COMBAT_TICK', 'DRG_WYVERN_COMBAT_TICK', trySummon)
end

return g_mixins.drg_wyvern
