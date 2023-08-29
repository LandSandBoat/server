-----------------------------------
-- Area: Valley of Sorrows
--  HNM: Aspidochelone
-----------------------------------
local ID = require("scripts/zones/Valley_of_Sorrows/IDs")
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/titles")
-----------------------------------
local entity = {}

local intoShell = function(mob)
    mob:setLocalVar("changeTime", os.time() + 90)
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
    local questionMarks = GetNPCByID(ID.npc.ADAMANTOISE_QM)
    if questionMarks ~= nil then
        questionMarks:setStatus(xi.status.DISAPPEAR)
    end

    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
    mob:setMobAbilityEnabled(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(false) -- will not cast until it goes into shell
    mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.STANDBACK)))
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.UDMGMAGIC, -3000)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMod(xi.mod.CURSERES, 100)
    mob:setMod(xi.mod.DEF, 702)
    mob:setMod(xi.mod.ATT, 446)
    mob:setMod(xi.mod.EVA, 325)
    mob:setMod(xi.mod.POISONRES, 10)
    mob:setMod(xi.mod.SLOWRES, 10)
    mob:setMod(xi.mod.GRAVITYRES, 10)
    mob:setMod(xi.mod.PARALYZERES, 15)
    mob:setMod(xi.mod.BLINDRES, 15)
    mob:setMod(xi.mod.SLEEPRES, 50)
    mob:setMod(xi.mod.STUNRES, 50)
    mob:setMod(xi.mod.SILENCERES, 30)

    mob:setLocalVar("dmgToChange", mob:getHP() - 1000)
    mob:setAnimationSub(2)
end

entity.onMobFight = function(mob, target)
    local changeHP = mob:getLocalVar("dmgToChange")

    if -- In shell
        mob:getAnimationSub() == 1 and
        (os.time() > mob:getLocalVar("changeTime") or mob:getHPP() == 100)
    then
        outOfShell(mob)
    end

    if mob:getHP() <= changeHP then
        if mob:getAnimationSub() == 1 then -- In shell
            mob:setLocalVar("dmgToChange", mob:getHP() - 1000)
            outOfShell(mob)
        elseif mob:getAnimationSub() == 2 then -- Out of shell
            intoShell(mob)
            mob:setLocalVar("dmgToChange", mob:getHP() - 1000)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.ASPIDOCHELONE_SINKER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    local questionMarks = GetNPCByID(ID.npc.ADAMANTOISE_QM)
    if questionMarks ~= nil then
        questionMarks:updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
    end
end

return entity
