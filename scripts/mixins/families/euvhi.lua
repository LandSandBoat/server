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

local function isMouthOpen(mob)
    local animSub = mob:getAnimationSub()

    -- 2nd bit (0b010) high indicates open
    if bit.band(animSub, 0x02) == 0x02 then
        return true
    end

    return false
end

local function openMouth(mob)
    local damage = 1 + mob:getMainLvl() / 2
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, damage)
    mob:setAnimationSub(2) -- TODO: the db.. mobs start with animsub 4 or 6? shouldn't even be possible
    mob:wait(2000)
end

local function closeMouth(mob)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 0)
    mob:setLocalVar('[euvhi]changeTime', GetSystemTime() + 80)
    mob:setLocalVar('closeMouth', 0)
    mob:setAnimationSub(1) -- TODO: db shows animsub 5?
    mob:wait(2000)
end

local function setAggressiveness(mob)
    if isMouthOpen(mob) then
        mob:setAggressive(true)
    else
        mob:setAggressive(false)
    end
end

g_mixins.families.euvhi = function(euvhiMob)
    euvhiMob:addListener('SPAWN', 'EUVHI_SPAWN', function(mob)
        mob:setLocalVar('defaultAnimation', mob:getAnimationSub())
        setAggressiveness(mob)
    end)

    euvhiMob:addListener('ENGAGE', 'EUVHI_ENGAGE', function(mob, target)
        mob:setLocalVar('[euvhi]changeTime', GetSystemTime() + 80)
    end)

    euvhiMob:addListener('COMBAT_TICK', 'EUVHI_CTICK', function(mob)
        if
            not isMouthOpen(mob) and
            GetSystemTime() > mob:getLocalVar('[euvhi]changeTime') and
            not xi.combat.behavior.isEntityBusy(mob)
        then
            openMouth(mob)
        elseif
            isMouthOpen(mob) and
            mob:getLocalVar('closeMouth') == 1 and
            not xi.combat.behavior.isEntityBusy(mob)
        then
            closeMouth(mob)
        end
    end)

    euvhiMob:addListener('TAKE_DAMAGE', 'EUVHI_TAKE_DAMAGE', function(mob, damage, attacker, attackType, damageType)
        if
            isMouthOpen(mob) and
            damage >= 350
        then
            mob:setLocalVar('closeMouth', 1)
        end
    end)

    euvhiMob:addListener('ROAM_TICK', 'EUVHI_RTICK', function(mob)
        setAggressiveness(mob)
    end)

    euvhiMob:addListener('DISENGAGE', 'EUVHI_DISENGAGE', function(mob)
        mob:setLocalVar('[euvhi]changeTime', 0)
        mob:setAnimationSub(mob:getLocalVar('defaultAnimation'))
        setAggressiveness(mob)
    end)
end

return g_mixins.families.euvhi
