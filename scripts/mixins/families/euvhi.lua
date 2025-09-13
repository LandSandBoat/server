-----------------------------------
--- Euvhi Family Mixin
--  https://ffxiclopedia.fandom.com/wiki/Category:Euvhi
--  https://www.bg-wiki.com/ffxi/Category:Euvhi
--  Euvhi open mouth after 80 seconds, and deal 1.5% base damage
--  Close mouth after taking 350 damage
-----------------------------------
require('scripts/globals/mixins')
-----------------------------------

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local function openMouth(mob)
    local damage = 1 + mob:getMainLvl() / 2
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, damage)
    mob:setAnimationSub(2)
    mob:wait(2000)
end

local function closeMouth(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
    mob:setLocalVar('[euvhi]changeTime', GetSystemTime() + 80)
    mob:setLocalVar('closeMouth', 0)
    mob:setAnimationSub(1)
    mob:wait(2000)
end

g_mixins.families.euvhi = function(euvhiMob)
    euvhiMob:addListener('SPAWN', 'EUVHI_SPAWN', function(mob)
        mob:setLocalVar('defaultAnimation', mob:getAnimationSub())
    end)

    euvhiMob:addListener('ENGAGE', 'EUVHI_ENGAGE', function(mob, target)
        mob:setLocalVar('[euvhi]changeTime', GetSystemTime() + 80)
    end)

    euvhiMob:addListener('COMBAT_TICK', 'EUVHI_CTICK', function(mob)
        if
            mob:getAnimationSub() == 1 and
            mob:getBattleTime() > mob:getLocalVar('[euvhi]changeTime') and
            not xi.combat.behavior.isEntityBusy(mob)
        then
            openMouth(mob)
        elseif
            mob:getAnimationSub() == 2 and
            mob:getLocalVar('closeMouth') == 1 and
            not xi.combat.behavior.isEntityBusy(mob)
        then
            closeMouth(mob)
        end
    end)

    euvhiMob:addListener('TAKE_DAMAGE', 'EUVHI_TAKE_DAMAGE', function(mob, damage, attacker, attackType, damageType)
        if
            mob:getAnimationSub() == 2 and
            damage >= 350
        then
            mob:setLocalVar('closeMouth', 1)
        end
    end)

    euvhiMob:addListener('ROAM_TICK', 'EUVHI_RTICK', function(mob)
        local animSub = mob:getAnimationSub()
        if animSub % 2 == 1 then
            mob:setAggressive(false)
        elseif animSub % 2 == 0 then
            mob:setAggressive(true)
        end
    end)

    euvhiMob:addListener('DISENGAGE', 'EUVHI_DISENGAGE', function(mob)
        mob:setLocalVar('[euvhi]changeTime', 0)
        mob:setAnimationSub(mob:getLocalVar('defaultAnimation'))
    end)
end

return g_mixins.families.euvhi
