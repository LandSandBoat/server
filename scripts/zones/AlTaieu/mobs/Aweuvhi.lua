-----------------------------------
-- Area: AlTaieu
--  Mob: Aw'euvhi
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
end

entity.onMobDeath = function(mob, player, optParams)
    local mobID = mob:getID()

    if
        mobID == ID.mob.EUVHIS_WHITE + 0 or
        mobID == ID.mob.EUVHIS_WHITE + 2 or
        mobID == ID.mob.EUVHIS_WHITE + 4
    then
        if not player:hasKeyItem(xi.ki.WHITE_CARD) then
            player:addKeyItem(xi.ki.WHITE_CARD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.WHITE_CARD)
        end

    elseif
        mobID == ID.mob.EUVHIS_RED + 0 or
        mobID == ID.mob.EUVHIS_RED + 2 or
        mobID == ID.mob.EUVHIS_RED + 4
    then
        if not player:hasKeyItem(xi.ki.RED_CARD) then
            player:addKeyItem(xi.ki.RED_CARD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.RED_CARD)
        end

    elseif
        mobID == ID.mob.EUVHIS_BLACK + 0 or
        mobID == ID.mob.EUVHIS_BLACK + 2 or
        mobID == ID.mob.EUVHIS_BLACK + 4
    then
        if not player:hasKeyItem(xi.ki.BLACK_CARD) then
            player:addKeyItem(xi.ki.BLACK_CARD)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, xi.ki.BLACK_CARD)
        end
    end
end

return entity
