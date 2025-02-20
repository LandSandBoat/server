-----------------------------------
-- Area: The Garden of Ru'Hmet
--  Mob: Aw'euvhi
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    -- Set a random animation when it spawns
    mob:setAnimationSub(math.random(1, 4))
end

entity.onMobFight = function(mob)
    -- Forms: 0 = Closed  1 = Closed  2 = Open 3 = Closed
    -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
    -- ..when attacked will change states every minute or so..
    local randomTime = math.random(50, 75)
    local changeTime = mob:getLocalVar('changeTime')

    if mob:getBattleTime() - changeTime > randomTime then
        if mob:getAnimationSub() == 2 then
            mob:setAnimationSub(1)
        else
            mob:setAnimationSub(2)
        end

        mob:setLocalVar('changeTime', mob:getBattleTime())

        -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
        -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
        -- Make everything do double
        local powerMod = 1000
        local powerSDT = 10000
        if mob:getAnimationSub() == 2 then
            powerMod = 2000
            powerSDT = -10000
        end

        mob:setMod(xi.mod.HTH_SDT, powerMod)
        mob:setMod(xi.mod.SLASH_SDT, powerMod)
        mob:setMod(xi.mod.PIERCE_SDT, powerMod)
        mob:setMod(xi.mod.IMPACT_SDT, powerMod)
        for element = xi.element.FIRE, xi.element.DARK do
            mob:setMod(xi.combat.element.getElementalMEVAModifier(element), powerMod)
            mob:setMod(xi.combat.element.getElementalSDTModifier(element), powerSDT)
        end
    end
end

entity.onCriticalHit = function(target)
    -- According to http://wiki.ffxiclopedia.org/wiki/Category:Euvhi
    -- When in an open state, damage taken by the Euvhi is doubled. Inflicting a large amount of damage to an Euvhi in an open state will cause it to close.
    -- Crit is really the only thing we can do.
    if target:getAnimationSub() == 2 then
        target:setAnimationSub(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
