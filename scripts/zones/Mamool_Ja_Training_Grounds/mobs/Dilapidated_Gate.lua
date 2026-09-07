-----------------------------------
-- Area: Mamool Ja Training Grounds
--  Mob: Dilapidated Gate
-- Involved in Assault: Imperial Agent Rescue
-----------------------------------
local ID = zones[xi.zone.MAMOOL_JA_TRAINING_GROUNDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addListener('WEAPONSKILL_TAKE', 'DILAPIDATED_GATE_WEAPONSKILL_TAKE', function(user, target, skill, tp, action)
        local skillId = skill:getID()

        if
            skillId == xi.mobSkill.FIRESPIT or
            skillId == xi.mobSkill.FIRESPIT_BLUE_MAMOOLJA
        then
            target:setLocalVar('hits', target:getLocalVar('hits') + 1)
        elseif
            skillId == xi.mobSkill.AXE_THROW or
            skillId == xi.mobSkill.STAVE_TOSS_1
        then
            target:setLocalVar('hits', target:getLocalVar('hits') + 4)
        end

        if target:getLocalVar('hits') >= 4 then
            target:setHP(0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:hideName(true)
    mob:hideHP(true)
    mob:setUntargetable(false)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_ASSIST))
    mob:setAutoAttackEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setLocalVar('hits', 0)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local instance = mob:getInstance()
        if not instance then
            return
        end

        local mobId = mob:getID()
        if mobId == ID.mob.DILAPIDATED_GATE then
            GetNPCByID(ID.npc._JU3, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob.DILAPIDATED_GATE + 1 then
            GetNPCByID(ID.npc._JU5, instance):setAnimation(xi.animation.OPEN_DOOR)
        elseif mobId == ID.mob.DILAPIDATED_GATE + 2 then
            GetNPCByID(ID.npc._JU7, instance):setAnimation(xi.animation.OPEN_DOOR)
        end
    end
end

return entity
