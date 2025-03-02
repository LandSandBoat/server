-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Percipient Zoraal Ja
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- make pkuucha killable
    local pet = GetMobByID(ID.mob.ZORAAL_JAS_PKUUCHA)
    if pet ~= nil then
        pet:setUnkillable(false)
        if pet:getHPP() <= 1 then
            pet:setHP(0)
        end
    end
end

return entity
