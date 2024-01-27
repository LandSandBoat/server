-----------------------------------
-- Area: Throne Room
--  Mob: Volker
-- Ally during Bastok Mission 9-2
-----------------------------------
local ID = zones[xi.zone.THRONE_ROOM]
-----------------------------------
local entity = {}

entity.onMobSpawn = function(volker)
    volker:addListener('WEAPONSKILL_STATE_ENTER', 'WS_START_MSG', function(mob, skillID)
        -- Red Lotus Blade
        if skillID == 973 then
            mob:showText(mob, ID.text.NO_HIDE_AWAY)
        -- Spirits Within
        elseif skillID == 974 then
            mob:showText(mob, ID.text.YOUR_ANSWER)
        -- Vorpal Blade
        elseif skillID == 975 then
            mob:showText(mob, ID.text.CANT_UNDERSTAND)
        end
    end)
end

entity.onMobRoam = function(mob)
    local wait = mob:getLocalVar('wait')
    local ready = mob:getLocalVar('ready')
    if ready == 0 and wait > 40 then
        local baseID = ID.mob.ZEID_BCNM_OFFSET + (mob:getBattlefield():getArea() - 1) * 4
        mob:setLocalVar('ready', bit.band(baseID, 0xFFF))
        mob:setLocalVar('wait', 0)
    elseif ready > 0 then
        mob:addEnmity(GetMobByID(ready + bit.lshift(mob:getZoneID(), 12) + 0x1000000), 0, 1)
    else
        mob:setLocalVar('wait', wait + 3)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    mob:getBattlefield():lose()
end

return entity
