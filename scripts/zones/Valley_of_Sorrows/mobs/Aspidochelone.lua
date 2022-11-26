-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/status")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local intoShell = function(mob)
    mob:setAnimationSub(1)
    mob:setMobAbilityEnabled(false)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(true)
    mob:setMod(xi.mod.REGEN, 200)
    mob:setMod(xi.mod.UDMGRANGE, -9500)
    mob:setMod(xi.mod.UDMGPHYS, -9500)
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.STANDBACK))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
end

local outOfShell = function(mob)
    mob:setTP(3000) -- Immediately TPs coming out of shell
    mob:setAnimationSub(2)
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGRANGE, 0)
    mob:setMod(xi.mod.UDMGPHYS, 0)
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
end

entity.onMobSpawn = function(mob)
    -- Despawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):setStatus(xi.status.DISAPPEAR)

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.DMGMAGIC, -3000)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.CURSERES, 100)

    local changeHP = mob:getHP() - (mob:getHP() * .05)
    mob:setLocalVar("changeHP", changeHP)
    mob:setLocalVar("DamageTaken", 0)
    mob:setAnimationSub(2)

    -- Forced out of shell after taking 2000 damage
    mob:addListener("TAKE_DAMAGE", "ASPID_TAKE_DAMAGE", function(mobArg, amount, attacker, attackType, damageType)
        local damageTaken = mobArg:getLocalVar("DamageTaken")
        local waitTime = mobArg:getLocalVar("waitTime")
        damageTaken = damageTaken + amount
        if damageTaken > 2000 then
            mobArg:setLocalVar("DamageTaken", 0)
            if mobArg:getAnimationSub() == 1 and os.time() > waitTime then
                mobArg:setAnimationSub(2)
                changeHP = mobArg:getHP() - (mobArg:getHP() * .05)
                mobArg:setLocalVar("changeHP", changeHP)
                mobArg:setLocalVar("waitTime", os.time() + 2)
                outOfShell(mobArg)
            end
        elseif os.time() > waitTime then
            mob:setLocalVar("DamageTaken", damageTaken)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local changeHP = mob:getLocalVar("changeHP")
    local waitTime = mob:getLocalVar("waitTime")

    if mob:getHP() < changeHP and mob:getAnimationSub() == 2 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(1)
        mob:setLocalVar("waitTime", os.time() + 2)
        intoShell(mob)
    elseif mob:getHPP() == 100 and mob:getAnimationSub() == 1 and os.time() > waitTime then
        mob:setLocalVar("DamageTaken", 0)
        mob:setAnimationSub(2)
        changeHP = mob:getHP() - (mob:getHP() * .05)
        mob:setLocalVar("changeHP", changeHP)
        mob:setLocalVar("waitTime", os.time() + 2)
        outOfShell(mob)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
    mob:removeListener("ASPID_TAKE_DAMAGE")
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.ADAMANTOISE_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
