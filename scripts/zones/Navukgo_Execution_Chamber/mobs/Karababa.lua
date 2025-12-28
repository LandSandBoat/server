-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Karababa
-----------------------------------
local ID = zones[xi.zone.NAVUKGO_EXECUTION_CHAMBER]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobFight = function(mob, target)
    local warp = mob:getLocalVar('warp')
    local wait = mob:getLocalVar('wait')
    if mob:getLocalVar('warp') == 2 and wait < GetSystemTime() then
        mob:getBattlefield():lose()
    end

    if mob:getHPP() <= 50 and mob:getLocalVar('powerup') == 0 then
        target:showText(mob, ID.text.KARABABA_ENOUGH)
        target:showText(mob, ID.text.KARABABA_ROUGH)
        mob:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 15, 0, 1800)
        mob:setLocalVar('powerup', 1)
    elseif mob:getHPP() <= 20 and warp == 0 then
        mob:setLocalVar('warp', 1)
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local powerup = mob:getLocalVar('powerup')
    local rnd = math.random(1, 6)
    local warp = mob:getLocalVar('warp')

    if warp == 1 then
        mob:showText(mob, ID.text.KARABABA_QUIT)
        mob:setLocalVar('warp', 2)
        mob:setLocalVar('wait', GetSystemTime() + 8)
        return xi.magic.spell.WARP
    elseif rnd == 1 then
        mob:showText(mob, ID.text.KARABARA_FIRE)
        return xi.magic.spell.FLARE_II - powerup
    elseif rnd == 2 then
        mob:showText(mob, ID.text.KARABARA_ICE)
        return xi.magic.spell.FREEZE_II - powerup
    elseif rnd == 3 then
        mob:showText(mob, ID.text.KARABARA_WIND)
        return xi.magic.spell.TORNADO_II - powerup
    elseif rnd == 4 then
        mob:showText(mob, ID.text.KARABARA_EARTH)
        return xi.magic.spell.QUAKE_II - powerup
    elseif rnd == 5 then
        mob:showText(mob, ID.text.KARABARA_LIGHTNING)
        return xi.magic.spell.BURST_II - powerup
    elseif rnd == 6 then
        mob:showText(mob, ID.text.KARABARA_WATER)
        return xi.magic.spell.FLOOD_II - powerup
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
end

return entity
