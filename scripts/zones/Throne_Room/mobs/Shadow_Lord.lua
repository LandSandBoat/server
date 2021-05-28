-----------------------------------
-- Area: Throne Room
--  Mob: Shadow Lord
-- Mission 5-2 BCNM Fight
-----------------------------------
local ID = require("scripts/zones/Throne_Room/IDs")
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    if mob:getID() >= ID.mob.SHADOW_LORD_STAGE_2_OFFSET then
        if GetMobByID(mob:getID() - 3):isDead() then
            local battlefield = mob:getBattlefield()
            battlefield:setLocalVar("phaseChange", 0)
        end
    end
end

entity.onMobFight = function(mob, target)
    -- 1st form
    -- after change magic or physical immunity every 5min or 1k dmg
    -- 2nd form
    -- the Shadow Lord will do nothing but his Implosion attack. This attack hits everyone in the battlefield, but he only has 4000 HP

    if (mob:getID() < ID.mob.SHADOW_LORD_STAGE_2_OFFSET) then -- first phase AI
        -- once he's under 50% HP, start changing immunities and attack patterns
        if (mob:getHP() / mob:getMaxHP() <= 0.5) then

            -- have to keep track of both the last time he changed immunity and the HP he changed at
            local changeTime = mob:getLocalVar("changeTime")
            local changeHP = mob:getLocalVar("changeHP")

            -- subanimation 0 is first phase subanim, so just go straight to magic mode
            if (mob:getAnimationSub() == 0) then
                mob:setAnimationSub(1)
                mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(true)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)
                --and record the time and HP this immunity was started
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 2 is physical mode, so check if he should change into magic mode
            elseif (mob:getAnimationSub() == 2 and (mob:getHP() <= changeHP - 1000 or
                    mob:getBattleTime() - changeTime > 300)) then
                mob:setAnimationSub(1)
                mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
                mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(false)
                mob:SetMagicCastingEnabled(true)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 2)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            -- subanimation 1 is magic mode, so check if he should change into physical mode
            elseif (mob:getAnimationSub() == 1 and (mob:getHP() <= changeHP - 1000 or
                    mob:getBattleTime() - changeTime > 300)) then
                -- and use an ability before changing
                mob:useMobAbility(673)
                mob:setAnimationSub(2)
                mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
                mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 0, 1, 0, 0)
                mob:SetAutoAttackEnabled(true)
                mob:SetMagicCastingEnabled(false)
                mob:setMobMod(xi.mobMod.MAGIC_COOL, 10)
                mob:setLocalVar("changeTime", mob:getBattleTime())
                mob:setLocalVar("changeHP", mob:getHP())
            end
        end
    else
        -- second phase AI: Implode every 9 seconds
        local lastImplodeTime = mob:getLocalVar("lastImplodeTime")
        -- second phase AI: Implode every 9 seconds
        if (mob:getBattleTime() - lastImplodeTime > 9) then
            mob:useMobAbility(669)
            mob:setLocalVar("lastImplodeTime", mob:getBattleTime())
        end
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    if (mob:getID() < ID.mob.SHADOW_LORD_STAGE_2_OFFSET) then
        player:startEvent(32004)
        player:setCharVar("mobid", mob:getID())
    else
        player:addTitle(xi.title.SHADOW_BANISHER)
    end
    -- reset everything on death
    mob:setAnimationSub(0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

entity.onMobDespawn = function(mob)
    -- reset everything on despawn
    mob:setAnimationSub(0)
    mob:SetAutoAttackEnabled(true)
    mob:SetMagicCastingEnabled(true)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 32004) then
        local mobid = player:getCharVar("mobid")
        DespawnMob(mobid)
        player:setCharVar("mobid", 0)

        -- first phase dies, spawn second phase ID, make him engage, and disable
        -- magic, auto attack, and abilities (all he does is case Implode by script)
        local mob = SpawnMob(mobid+3)
        mob:updateEnmity(player)
        mob:SetMagicCastingEnabled(false)
        mob:SetAutoAttackEnabled(false)
        mob:SetMobAbilityEnabled(false)
    end
end

return entity
