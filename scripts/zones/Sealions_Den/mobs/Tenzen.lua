-----------------------------------
-- Area: Sealion's Den
--  Mob: Tenzen
-----------------------------------
local ID = require("scripts/zones/Sealions_Den/IDs")
local tenzenFunctions = require("scripts/zones/Sealions_Den/helpers/TenzenFunctions")
require("scripts/globals/msg")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Tenzen in Warriors Path is a completely scripted encounter once you trigger certain states
    -- Leaving mods here as visuals
    mob:setMod(xi.mod.DEF, 350)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
    mob:setMobMod(xi.mobMod.SIGHT_RANGE, 10)
    mob:setAnimationSub(0)
    mob:setMobSkillAttack(0)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setUnkillable(true)
    mob:setLocalVar("skillchain", math.random(1, 100)) -- set chance that Tenzen will use Cosmic Elucidation
    mob:setLocalVar("twohourthreshold", math.random(75, 80)) -- set HP threshold for Meikyo Shisui usage
end

entity.onMobEngaged = function(mob, target)
    mob:showText(mob, ID.text.TENZEN_MSG_OFFSET + 1)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    -- three tarus fight with tenzen
    local mobId  = mob:getID()
    local offset = mobId - ID.mob.WARRIORS_PATH_OFFSET

    if
        offset >= 0 and
        offset <= 8
    then
        for i = mobId + 1, mobId + 3 do
            GetMobByID(i):updateEnmity(target)
        end
    end
end

entity.onMobFight = function(mob, target)
    -- Uses Meikyo Shisui around 75-80% Hanaikusa > Torimai > Kazakiri > Tsukikage > Cosmic Elucidation
    local twohourtrigger   = mob:getLocalVar("twohourtrigger")
    local twohourthreshold = mob:getLocalVar("twohourthreshold")

    if
        mob:getHPP() < twohourthreshold and
        twohourtrigger == 0
    then -- first meikyo shisui usage 75-85%
        tenzenFunctions.firstMeikyo(mob)
    elseif
        mob:getHPP() < twohourthreshold and
        twohourtrigger == 2
    then -- second meikyo shisui usage 45-55%
        tenzenFunctions.secondMeikyo(mob)
    end

    local isBusy = false
    local act    = mob:getCurrentAction()

    if
        act == xi.act.MOBABILITY_START or
        act == xi.act.MOBABILITY_USING or
        act == xi.act.MOBABILITY_FINISH
    then
        isBusy = true -- is set to true if Tenzen is in any stage of using a mobskill
    end

    -- scripted sequence of weaponskills in order to potentially create the level 4 skillchain cosmic elucidation
    if
        mob:actionQueueEmpty() and
        not isBusy
    then
        tenzenFunctions.wsSequence(mob)
    end

    tenzenFunctions.formSwap(mob)

    -- win condition set
    local battlefield = mob:getBattlefield()
    if
        battlefield:getID() == 993 and
        mob:getHPP() <= 15
    then -- Tenzen gives up at 15% - win
        mob:showText(target, ID.text.TENZEN_MSG_OFFSET + 2)
        mob:setAnimationSub(5)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        battlefield:win()
        return
    end

    tenzenFunctions.riceBall(mob, target, isBusy)

    if mob:getHPP() > 35 then
        mob:setMod(xi.mod.REGAIN, 30)
    else
        mob:setMod(xi.mod.REGAIN, 70)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
