-----------------------------------
-- Area: Wajaom Woodlands
--  Mob: Percipient Zoraal Ja
-----------------------------------
local ID = zones[xi.zone.WAJAOM_WOODLANDS]
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    -- make pkuucha killable
    local pet = GetMobByID(ID.mob.ZORAAL_JA_S_PKUUCHA)
    if pet ~= nil then
        pet:setUnkillable(false)
        if pet:getHPP() <= 1 then
            pet:setHP(0)
        end
    end
end

return entity
