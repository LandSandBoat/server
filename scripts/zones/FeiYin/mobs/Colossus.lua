-----------------------------------
-- Area: FeiYin
--  Mob: Colossus
-- Note: PH for Goliath
-----------------------------------
local ID = zones[xi.zone.FEIYIN]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 715, 2, xi.regime.type.GROUNDS)
end

entity.onMobDespawn = function(mob)
    -- Confirmed on retail:
    -- This shares a slot with every colossus and goliath in the small rooms
    -- Only 1 Colossus or Goliath can be up at a time even though Goliath is an NM
    -- There is no cooldown on Goliath spawns (Able to pop back to back)
    -- Set to pure lottery This is used to mimic the spawn slot system until Chance var if fixed
    xi.mob.phOnDespawn(mob, ID.mob.GOLIATH, 15, 1) -- "Pure Lottery"
end

return entity
