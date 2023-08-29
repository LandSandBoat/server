-----------------------------------
-- Area: Abyssea - La Theine
--  Mob: Briareus
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
local entity = {}

local useMeikyoShisui = function(mob)
    mob:useMobAbility(xi.jsa.MEIKYO_SHISUI)
end

local mercurialEffects =
{
    -- [damage 'roll'] = { move to cue, extra logic }
    [ 111] = {  664, nil }, -- Impact Roar
    [ 222] = {  665, nil }, -- Grand Slam
    [ 333] = {  665, nil }, -- Grand Slam
    [ 444] = {  667, nil }, -- Power Attack
    [ 555] = { 1636, nil }, -- Trebuchet
    [ 666] = { 1636, nil }, -- Trebuchet
    [ 777] = { 2576, nil }, -- Mercurial Strike + JA Reset (NOTE: No need for JA reset)
    [ 888] = { 2578, nil }, -- Colossal Slam
    [ 999] = { 2578, nil }, -- Colossal Slam
    [1111] = { 2578, useMeikyoShisui }, -- Colossal Slam + 2H
}

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 5400) -- 90 minutes
end

entity.onMobFight = function(mob, target)
    local mercDamage = mob:getLocalVar('MERCURIAL_STRIKE_DAMAGE')
    if mercDamage > 0 then
        mob:setLocalVar('CUE_MOVE', mercurialEffects[mercDamage][1])
        if type(mercurialEffects[mercDamage][2]) == 'function' then
            mercurialEffects[mercDamage][2](mob)
        end

        mob:setLocalVar('MERCURIAL_STRIKE_DAMAGE', 0)
    end

    -- Use Colossal Slam as many times as possible!
    if mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI) then
        mob:setTP(1000)
        mob:setMobMod(xi.mobMod.TP_USE_CHANCE, 10000)
    else
        mob:setMobMod(xi.mobMod.TP_USE_CHANCE, 200)
    end
end

entity.onMobWeaponSkillPrepare = function(mob, target)
    local cueMove = mob:getLocalVar('CUE_MOVE')
    mob:setLocalVar('CUE_MOVE', 0)

    if mob:hasStatusEffect(xi.effect.MEIKYO_SHISUI) then
        -- Use Colossal Slam as many times as possible!
        cueMove = 2578
    end

    return cueMove
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BRIAREUS_FELLER)
end

return entity
