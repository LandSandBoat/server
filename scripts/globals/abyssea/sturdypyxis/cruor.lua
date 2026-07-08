-----------------------------------
-- Abyssea Sturdy Pyxis - Cruor
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.cruor = {}

xi.pyxis.cruor.giveCruor = function(npc, player)
    local ID = zones[npc:getZoneID()]
    local alliance = player:getAlliance()
    local cruorAmount = npc:getLocalVar('CRUOR')

    for p, member in ipairs(alliance) do
        if
            member:getZoneID() == player:getZoneID() and
            member:isPC()
        then
            member:addCurrency('cruor', cruorAmount)
            member:messageSpecial(ID.text.CRUOR_OBTAINED, cruorAmount)
        end
    end
end
