-----------------------------------
-- Area: Lebros Cavern (Excavation Duty)
--  Mob: Brittle Rock
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
require("scripts/globals/status")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.DMG, -9800)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:SetAutoAttackEnabled(false)
    mob:setMod(xi.mod.DEF, 1500)
    mob:setMod(xi.mod.MDEF, 900)
end

entity.onMobDeath = function(mob, player, isKiller)
    local instance = mob:getInstance()
    if mob:getID() == ID.mob[21].BRITTLE_ROCK1 then
        GetNPCByID(ID.npc._1rx, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK2 then
        GetNPCByID(ID.npc._1ry, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK3 then
        GetNPCByID(ID.npc._1rz, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK4 then
        GetNPCByID(ID.npc._ir0, instance):setAnimation(8)
    elseif mob:getID() == ID.mob[21].BRITTLE_ROCK5 then
        GetNPCByID(ID.npc._ir1, instance):setAnimation(8)
    end
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    instance:setProgress(instance:getProgress() + 1)
end

return entity
