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
    local randomTime = math.random(50, 75)
    local changeTime = mob:getLocalVar('changeTime')

    if mob:getBattleTime() - changeTime > randomTime then
        local sdtPower = 0

        if mob:getAnimationSub() == 2 then -- Change to closed.
            mob:setAnimationSub(1)
            sdtPower = 5000 -- 50% more dmg taken.
        else -- Change to open.
            mob:setAnimationSub(2)
        end

        mob:setLocalVar('changeTime', mob:getBattleTime())

        -- Set physical SDT modifiers.
        mob:setMod(xi.mod.HTH_SDT, sdtPower)
        mob:setMod(xi.mod.SLASH_SDT, sdtPower)
        mob:setMod(xi.mod.PIERCE_SDT, sdtPower)
        mob:setMod(xi.mod.IMPACT_SDT, sdtPower)
    end
end

entity.onCriticalHit = function(target)
    if target:getAnimationSub() == 2 then
        target:setAnimationSub(1)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
