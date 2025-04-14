-----------------------------------
-- Area: Bibiki Bay (Purgonorgo Isle)
--  Mob: Rohemolipaud
-- Quest: The Search for Goldmane
--
-- TODO: Rohemolipaud is firing acid bolts at the player. We have no method of handling a mob doing this.
-----------------------------------
---@type TMobEntity
local entity = {}

local bibikiID = zones[xi.zone.BIBIKI_BAY]
local weatheredBoat = GetNPCByID(bibikiID.npc.WEATHERED_BOAT_OFFSET)

-- Confirms the player that spawned the fight is the only one that can increase the var.
local confirmQuestPlayer = function(target, questPlayer)
    local alliance
    if target:isPet() then
        alliance = target:getMaster():getAlliance()
    else
        alliance = target:getAlliance()
    end

    for _, member in pairs(alliance) do
        local ally = member
        if
            ally:getID() == questPlayer and
            ally:getZone():getID() == xi.zone.BIBIKI_BAY
        then
            xi.quest.setVar(target, 5, 200, 'Prog', 6)
        end
    end
end

--Controls the camo and despawn.
local runAway = function(mob, target)
    mob:clearActionQueue()
    -- Rohemolipaud will use the player category animation for Camouflage. This can not be used by mobskills.sql. Had to null the skill use and manually call the correct one here.
    mob:independentAnimation(mob, 10, 2)
    mob:messageBasic(xi.msg.basic.JA_GAIN_EFFECT, 0, xi.effect.CAMOUFLAGE)
    mob:setLocalVar('fightEnd', 1)

    mob:messageText(mob, bibikiID.text.ROHEMOLIPAUD_SURRENDER)

    if weatheredBoat then
        local questPlayer = weatheredBoat:getLocalVar('QuestPlayer')
        confirmQuestPlayer(target, questPlayer)
        weatheredBoat:setLocalVar('QuestPlayer', 0)
    end

    local mobID = mob:getID()
    DespawnMob(mobID)
end

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, 40)
    mob:setMobMod(xi.mobMod.STANDBACK_RANGE, 13)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addMod(xi.mod.POISON_IMMUNOBREAK, 1)
    mob:setUnkillable(true) -- Can not be killed by players, even with massive overkill. Will run fight disengage below 15% HP.
end

entity.onMobFight = function(mob, target)
    -- Rohemolipaud will use EES_ELVAAN at 52% HP and 48% chance to use it again immediately. This 2hr does not play the "cloud" animation.
    if
        mob:getHPP() < 52 and
            mob:getLocalVar('can2hr') == 0
    then
        mob:useMobAbility(711)
        local doubleUp = math.random(1, 10)
        if doubleUp <= 4 then
            mob:useMobAbility(711)
        end

        mob:setLocalVar('can2hr', 1)
    end

    --Will Camouflage at 30% HP and despawn immediately.
    if
        mob:getHPP() <= 30 and
            mob:getLocalVar('fightEnd') == 0
    then
        -- Helper function to handle the camo and despawn.
        runAway(mob, target)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    -- Rohemolipaud uses the player category animation for EES_ELVAAN. This can not be used by mobskills.sql. Had to null the animID and manually call the correct one here.
    if skill:getID() == 711 then
        mob:independentAnimation(target, 187, 6)
    end
end

-- Remove me once debugging is complete.
entity.onMobDespawn = function(mob)
    if weatheredBoat then
        weatheredBoat:setLocalVar('Wait', os.time() + 180)
    end
end

return entity
