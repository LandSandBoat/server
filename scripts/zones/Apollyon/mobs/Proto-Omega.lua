-----------------------------------
-- Area: Apollyon (Central)
--  Mob: Proto-Omega
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/mobs")
local ID = require("scripts/zones/Apollyon/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.COUNTER, 10) -- "Possesses a Counter trait"
    mob:setMod(xi.mod.REGEN, 25) -- "Posseses an Auto-Regen (low to moderate)"
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.SUPERLINK, mob:getShortID())
    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setMod(xi.mod.UDMGPHYS, -75)
    mob:setMod(xi.mod.UDMGRANGE, -75)
    mob:setMod(xi.mod.UDMGMAGIC, 0)
    mob:setMod(xi.mod.MOVE, 100) -- "Moves at Flee Speed in Quadrupedal stance and in the Final Form"
end

entity.onMobFight = function(mob, target)
    local mobID = mob:getID()
    local formTime = mob:getLocalVar("formWait")
    local lifePercent = mob:getHPP()
    local currentForm = mob:getLocalVar("form")

    if lifePercent < 70 and currentForm < 1 then
        currentForm = 1
        mob:setLocalVar("form", currentForm)
        formTime = os.time()
        mob:setMod(xi.mod.UDMGPHYS, 0)
        mob:setMod(xi.mod.UDMGRANGE, 0)
        mob:setMod(xi.mod.UDMGMAGIC, -75)
        mob:setMod(xi.mod.MOVE, 0)
    end

    if currentForm == 1 then
        if formTime < os.time() then
            if mob:getAnimationSub() == 1 then
                mob:setAnimationSub(2)
                mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
                if not GetMobByID(mobID + 1):isSpawned() and math.random(0,1) == 1 then
                    mob:useMobAbility(1532)
                end
            else
                mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
                mob:setAnimationSub(1)
            end
            mob:setLocalVar("formWait", os.time() + 60)
        end

        if lifePercent < 30 then
            mob:setAnimationSub(2)
            mob:setBehaviour(bit.band(mob:getBehaviour(), bit.bnot(xi.behavior.NO_TURN)))
            mob:setMod(xi.mod.UDMGPHYS, -50)
            mob:setMod(xi.mod.UDMGRANGE, -50)
            mob:setMod(xi.mod.UDMGMAGIC, -50)
            mob:setMod(xi.mod.MOVE, 100)
            mob:addStatusEffect(xi.effect.REGAIN,7,3,0) -- The final form has Regain,
            mob:getStatusEffect(xi.effect.REGAIN):setFlag(xi.effectFlag.DEATH)
            currentForm = 2
            mob:setLocalVar("form", currentForm)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN)
end

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if player then
        player:addTitle(xi.title.APOLLYON_RAVAGER)
    end
    if isKiller or noKiller then
        GetNPCByID(ID.npc.APOLLYON_CENTRAL_CRATE):setStatus(xi.status.NORMAL)
    end
end

return entity
