-----------------------------------
-- Area: Xarcabard
--   NM: Barbaric Weapon
--  WOTG Nov 2009 NM: Immune to Bind, Sleep, Gravity. Uses only 1 TP move.
-----------------------------------
local ID = zones[xi.zone.XARCABARD]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.phList =
{
    [ID.mob.BARBARIC_WEAPON - 23] = ID.mob.BARBARIC_WEAPON, -- Confirmed on retail
    [ID.mob.BARBARIC_WEAPON - 2]  = ID.mob.BARBARIC_WEAPON, -- Confirmed on retail
}

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:setMod(xi.mod.STORETP, 80)
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    -- Gains Dread Spikes effect when using Whirl of Rage TP move
    if skill:getID() == 514 then
        mob:addStatusEffect(xi.effect.DREAD_SPIKES, { power = 10, duration = 180, origin = mob, icon = 0, subPower = 310, tier = 1, silent = true })
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 318)
end

entity.onMobDespawn = function(mob)
end

return entity
