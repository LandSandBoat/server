--[[
https://ffxiclopedia.fandom.com/wiki/Category:Hpemde
https://www.bg-wiki.com/ffxi/Category:Hpemde
--]]
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function dive(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMobAbilityEnabled(false)

    -- Om'hpedme in north half of Al'Taieu do not dive or become untargetable
    if mob:getPool() ~= 7033 then
        mob:hideName(true)
        mob:setUntargetable(true)
        mob:setAnimationSub(5)
    end
end

local function surface(mob)
    mob:hideName(false)
    mob:setUntargetable(false)
    local animationSub = mob:getAnimationSub()
    if animationSub == 0 or animationSub == 5 then
        mob:setAnimationSub(6)
        mob:wait(2000)
    end
end

local function openMouth(mob)
    mob:addMod(xi.mod.ATTP, 100)
    mob:addMod(xi.mod.DEFP, -50)
    mob:addMod(xi.mod.DMGMAGIC, -5000)
    mob:setLocalVar('[hpemde]closeMouthHP', mob:getHP() - math.ceil(mob:getMaxHP() / 3))
    mob:setAnimationSub(3)
    mob:wait(2000)
end

local function closeMouth(mob)
    mob:delMod(xi.mod.ATTP, 100)
    mob:delMod(xi.mod.DEFP, -50)
    mob:delMod(xi.mod.DMGMAGIC, -5000)
    mob:setLocalVar('[hpemde]changeTime', mob:getBattleTime() + 30)
    mob:setAnimationSub(6)
    mob:wait(2000)
end

g_mixins.families.hpemde = function(hpemdeMob)
    hpemdeMob:addListener('SPAWN', 'HPEMDE_SPAWN', function(mob)
        mob:setMod(xi.mod.REGEN, 10)
        dive(mob)
    end)

    hpemdeMob:addListener('ROAM_TICK', 'HPEMDE_RTICK', function(mob)
        if mob:getHPP() == 100 then
            mob:setLocalVar('[hpemde]damaged', 0)
        end

        if mob:getAnimationSub() ~= 5 then
            dive(mob)
        end
    end)

    hpemdeMob:addListener('ENGAGE', 'HPEMDE_ENGAGE', function(mob, target)
        mob:setLocalVar('[hpemde]disengageTime',  mob:getBattleTime() + 45)
        surface(mob)
    end)

    hpemdeMob:addListener('MAGIC_TAKE', 'HPEMDE_MAGIC_TAKE', function(target, caster, spell)
        target:setLocalVar('[hpemde]disengageTime',  target:getBattleTime() + 45)
    end)

    hpemdeMob:addListener('COMBAT_TICK', 'HPEMDE_CTICK', function(mob)
        if mob:getLocalVar('[hpemde]damaged') == 0 then
            local disengageTime = mob:getLocalVar('[hpemde]disengageTime')

            if mob:getHP() < mob:getMaxHP() then
                mob:setAutoAttackEnabled(true)
                mob:setMobAbilityEnabled(true)
                mob:setLocalVar('[hpemde]damaged', 1)
                mob:setLocalVar('[hpemde]changeTime', mob:getBattleTime() + 30)
            elseif disengageTime > 0 and mob:getBattleTime() > disengageTime then
                mob:setLocalVar('[hpemde]disengageTime',  0)
                mob:disengage()
            end
        else
            if
                mob:getAnimationSub() == 6 and
                mob:getBattleTime() > mob:getLocalVar('[hpemde]changeTime')
            then
                openMouth(mob)
            elseif
                mob:getAnimationSub() == 3 and
                mob:getHP() <  mob:getLocalVar('[hpemde]closeMouthHP')
            then
                closeMouth(mob)
            end
        end
    end)

    hpemdeMob:addListener('CRITICAL_TAKE', 'HPEMDE_CRITICAL_TAKE', function(mob)
        if mob:getAnimationSub() == 3 then
            closeMouth(mob)
        end
    end)
end

return g_mixins.families.hpemde
