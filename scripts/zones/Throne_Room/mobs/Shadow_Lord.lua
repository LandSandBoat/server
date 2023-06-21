-----------------------------------
-- Area: Throne Room
--  Mob: Shadow Lord
-- Mission 5-2 BCNM Fight
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobFight = function(mob, target)
    -- 1st form
    -- after change magic or physical immunity every 5min or 1k dmg
    -- 2nd form
    -- the Shadow Lord will do nothing but his Implosion attack. This attack hits everyone in the battlefield, but he only has 4000 HP

    if mob:getID() < ID.mob.SHADOW_LORD_PHASE_2_OFFSET then -- first phase AI
        -- once he's under 50% HP, start changing immunities and attack patterns
        if mob:getHP() / mob:getMaxHP() <= 0.5 then

            -- have to keep track of both the last time he changed immunity and the HP he changed at
            local changeTime = mob:getLocalVar("changeTime")
            local changeHP = mob:getLocalVar("changeHP")

            -- subanimation 0 is first phase subanim, so just go straight to magic mode
            if mob:getAnimationSub() == 0 then
                mob:setAnimationSub(1)
                mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(true)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)
                --and record the time and HP this immunity was started
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 2 is physical mode, so check if he should change into magic mode
            elseif
                mob:getAnimationSub() == 2 and
                (mob:getHP() <= changeHP - 1000 or
                mob:getBattleTime() - changeTime > 300)
            then
                mob:setAnimationSub(1)
                mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:setAutoAttackEnabled(false)
                mob:setMagicCastingEnabled(true)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 1 is magic mode, so check if he should change into physical mode
            elseif
                mob:getAnimationSub() == 1 and
                (mob:getHP() <= changeHP - 1000 or
                mob:getBattleTime() - changeTime > 300)
            then
                -- and use an ability before changing
                mob:useMobAbility(673)
                mob:setAnimationSub(2)
                mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
                mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
                mob:setAutoAttackEnabled(true)
                mob:setMagicCastingEnabled(false)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            end
        end
    else
        -- second phase AI: Implode every 9 seconds
        local lastImplodeTime = mob:getLocalVar("lastImplodeTime")
        if mob:getBattleTime() - lastImplodeTime > 9 then
            mob:useMobAbility(669)
            mob:setLocalVar("lastImplodeTime", mob:getBattleTime())
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    -- reset everything on death
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

entity.onMobDespawn = function(mob)
    -- reset everything on despawn
    mob:setAnimationSub(0)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

return entity
