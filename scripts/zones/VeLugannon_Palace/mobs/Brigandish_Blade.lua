-----------------------------------
-- Area: VeLugannon Palace
--   NM: Brigandish Blade
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
end

local BB_physical_SDTs =
{
    xi.mod.SLASH_SDT, xi.mod.PIERCE_SDT, xi.mod.IMPACT_SDT, xi.mod.HTH_SDT,
}
local BB_elemental_SDTs =
{
    xi.mod.FIRE_SDT, xi.mod.ICE_SDT, xi.mod.WIND_SDT, xi.mod.EARTH_SDT,
    xi.mod.THUNDER_SDT, xi.mod.WATER_SDT, xi.mod.LIGHT_SDT, xi.mod.DARK_SDT,
}

entity.onMobSpawn = function(mob)
    mob:setUnkillable(true)
    mob:addListener("TAKE_DAMAGE", "BRIGANDISH_AT_ONE_PERCENT", function(defender, amount, attacker, attackType, damageType)
        if defender:getHP() == 1 then
            for _, SDT in ipairs(BB_physical_SDTs) do
                defender:setMod(SDT, 0)
            end
            for _, SDT in ipairs(BB_elemental_SDTs) do
                defender:setMod(SDT, 10000)
            end
            defender:setLocalVar("STDAPPLIED", 1)
            defender:removeListener("BRIGANDISH_AT_ONCE_PERCENT")
        end
    end)
    mob:addListener("TAKE_DAMAGE", "BRIGANDISH_POTENTIAL_DEATH_DAMAGE", function(defender, amount, attacker, attackType, damageType)
        if
            defender:getLocalVar("STDAPPLIED") == 1 and
            attackType == xi.attackType.PHYSICAL and
            attacker:getObjType() == xi.objType.PC and
            attacker:getEquipID(xi.slot.MAIN) == xi.items.BUCCANEERS_KNIFE
        then
            defender:setUnkillable(false)
            defender:setMod(xi.mod.WATER_SDT, 0)
        end
    end)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TERROR, {chance = 30})
end

entity.onMobDeath = function(mob, player, isKiller)
    GetNPCByID(ID.npc.QM3):setLocalVar("PillarCharged", 1)
end

return entity
