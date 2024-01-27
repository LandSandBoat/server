-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Dilapidated_Gate
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:addListener('WEAPONSKILL_TAKE', 'DILAPIDATED_GATE_WEAPONSKILL_TAKE', function(target, attacker, skillId, tp, action)
        if skillId == 1733 or skillId == 1923 then -- firespit
            target:setLocalVar('hits', target:getLocalVar('hits') + 1)
        elseif skillId == 1736 or skillId == 1925 then --Axe Throw or Stave Toss
            target:setLocalVar('hits', target:getLocalVar('hits') + 4)
        end

        if target:getLocalVar('hits') >= 4 then
            target:setHP(0)
        end
    end)
end

entity.onMobDeath = function(mob, player, optParams)
    local instance = mob:getInstance()
    local mobID = mob:getID()
    if mobID == ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].MOBS_START.GATE_1 then
        GetNPCByID(ID.npc.DOOR_1, instance):setAnimation(8)
    elseif mobID == ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].MOBS_START.GATE_2 then
        GetNPCByID(ID.npc.DOOR_2, instance):setAnimation(8)
    elseif mobID == ID.mob[xi.assault.mission.IMPERIAL_AGENT_RESCUE].MOBS_START.GATE_3 then
        GetNPCByID(ID.npc.DOOR_3, instance):setAnimation(8)
    end
end

return entity
