-----------------------------------
-- Abyssea Sturdy Pyxis - Time
-----------------------------------

xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.time = {}

xi.pyxis.time.giveTime = function(npc, player)
    local ID = zones[npc:getZoneID()]
    local alliance = player:getAlliance()
    for p, member in ipairs(alliance) do
        if member:getZoneID() == player:getZoneID() and member:isPC() then
            member:messageSpecial(ID.text.ABYSSEA_TIME_OFFSET + 3, 10, 1)
            local effect = member:getStatusEffect(xi.effect.VISITANT)
            local oldDuration = tonumber(effect:getTimeRemaining())
            local newDuration = (oldDuration + tonumber(10 * 60)) * 1000
            effect:setDuration(newDuration)
            effect:resetStartTime()
            effect:setIcon(xi.effect.VISITANT)
        end
    end
end