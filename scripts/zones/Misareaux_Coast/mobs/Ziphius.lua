-----------------------------------
-- Area: Misareaux Coast
--   NM: Ziphius
-----------------------------------
require("scripts/globals/hunts")
local ID = require("scripts/zones/Misareaux_Coast/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENWATER)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 445)

    -- Set respawn timer for ???s
    for i = 0, 5 do
        GetNPCByID(ID.npc.ZIPHIUS_QM_BASE + i):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
