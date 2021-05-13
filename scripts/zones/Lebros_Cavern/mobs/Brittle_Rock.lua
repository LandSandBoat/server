-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
-- Mob: Brittle Rock
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/missions")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    --[[ TODO: Handle these
    mob:addStatusEffect(xi.effect.NO_REST, 1, 0, 0)
    mob:addImmunity(xi.immunity.POISON)
    mob:addImmunity(xi.immunity.LIGHTSLEEP)
    mob:addImmunity(xi.immunity.DARKSLEEP)
    mob:setMobMod(xi.mobMod.EXP_BONUS, -100)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(xi.mod.UDMGPHYS,-75)
    mob:setMod(xi.mod.UDMGBREATH,-95)
    mob:setMod(xi.mod.UDMGRANGE,-95)
    mob:setMod(xi.mod.UDMGMAGIC, -90)
    mob:setMod(xi.mod.EVA, 0)
    mob:setMod(xi.mod.CURSEEVA, 9999)
    ]]
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.NO_DROPS, 1)
    mob:addListener("WEAPONSKILL_TAKE", "BRITTLE_ROCK_WEAPONSKILL_TAKE", function(mob, user, wsid)
        if wsid == 1838 then
            mob:setHP(0)
        end
    end)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, isKiller)
    local instance = mob:getInstance()
    if mob:getID() == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK1 then
        GetNPCByID(ID.npc._1rx, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK2 then
        GetNPCByID(ID.npc._1ry, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK3 then
        GetNPCByID(ID.npc._1rz, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK4 then
        GetNPCByID(ID.npc._jr0, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[EXCAVATION_DUTY].MOBS_START.BRITTLE_ROCK5 then
        GetNPCByID(ID.npc._jr1, instance):setAnimation(8)
    end

    if mob:getLocalVar("Killed") == 0 then
        instance:setProgress(instance:getProgress() + 1)
        mob:setLocalVar("Killed", 1)
    end
end

return entity
