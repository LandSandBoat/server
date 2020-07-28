-----------------------------------
-- Area: Temenos
--  Mob: Proto-Ultima
-----------------------------------
require("scripts/globals/titles")
require("scripts/globals/limbus")
-----------------------------------

function onMobSpawn(mob)
    mob:SetMagicCastingEnabled(false)
end

function onMobFight(mob, target)
    local phase = mob:getLocalVar("battlePhase")
    if (mob:actionQueueEmpty() == true) then
        if (mob:getHPP() < (80 - (phase * 20))) then
            mob:useMobAbility(1524) -- use Dissipation on phase change
            phase = phase + 1
            if (phase == 2) then -- enable Holy II
                mob:SetMagicCastingEnabled(true)
            end
            if (phase == 4) then -- add Regain in final phase
                if (mob:hasStatusEffect(tpz.effect.REGAIN) == false) then
                    mob:addStatusEffect(tpz.effect.REGAIN, 7, 3, 0)
                    mob:getStatusEffect(tpz.effect.REGAIN):setFlag(tpz.effectFlag.DEATH)
                end
            end
            mob:setLocalVar("battlePhase", phase) -- incrementing the phase here instead of in the Dissipation skill because stunning it prevents use.
        end
    end
end

function onMobDeath(mob, player, isKiller)
    player:addTitle(tpz.title.TEMENOS_LIBERATOR)
    GetNPCByID(16928768+79):setPos(-559, 5, -357)
    GetNPCByID(16928768+79):setStatus(tpz.status.NORMAL)
    GetNPCByID(16928768+474):setStatus(tpz.status.NORMAL)
end
