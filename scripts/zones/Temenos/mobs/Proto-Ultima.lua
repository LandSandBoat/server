-----------------------------------
-- Area: Temenos
--  Mob: Proto-Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/limbus")
local ID = require("scripts/zones/Temenos/IDs")

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
    mob:SetAutoAttackEnabled(true)
    mob:SetMobAbilityEnabled(true)
    mob:setMobMod(tpz.mobMod.DRAW_IN, 0)
end

function onMobEngaged(mob, target)
    tpz.limbus.setupArmouryCrates(mob:getBattlefieldID(), true)
end

function onMobFight(mob, target)
    local phase = mob:getLocalVar("battlePhase")
    if mob:actionQueueEmpty() then
        if mob:getHPP() < (80 - (phase * 20)) then
            mob:useMobAbility(1524) -- use Dissipation on phase change
            phase = phase + 1
            if phase == 2 then -- enable Holy II
                mob:SetMagicCastingEnabled(true)
            end
            if phase == 4 then -- add Regain in final phase
                if not mob:hasStatusEffect(tpz.effect.REGAIN) then
                    mob:addStatusEffect(tpz.effect.REGAIN, 7, 3, 0)
                    mob:getStatusEffect(tpz.effect.REGAIN):setFlag(tpz.effectFlag.DEATH)
                end
            end
            mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
        end
    end
end

function onMobDeath(mob, player, isKiller, noKiller)
    if player then
        player:addTitle(tpz.title.TEMENOS_LIBERATOR)
    end
    if isKiller or noKiller then
        GetNPCByID(ID.npc.TEMENOS_C_CRATE[4][1]):setStatus(tpz.status.NORMAL)
    end
end
