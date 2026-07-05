-----------------------------------
-- Expeditionary Force
-----------------------------------
xi = xi or {}
xi.expeditionaryForce = xi.expeditionaryForce or {}

-----------------------------------
-- Tables
-----------------------------------

local regionKITable =
{
    [xi.region.ARAGONEU]         = xi.ki.ARAGONEU_EF_INSIGNIA,
    [xi.region.DERFLAND]         = xi.ki.DERFLAND_EF_INSIGNIA,
    [xi.region.ELSHIMO_LOWLANDS] = xi.ki.ELSHIMO_LOWLANDS_EF_INSIGNIA,
    [xi.region.ELSHIMO_UPLANDS]  = xi.ki.ELSHIMO_UPLANDS_EF_INSIGNIA,
    [xi.region.FAUREGANDI]       = xi.ki.FAUREGANDI_EF_INSIGNIA,
    [xi.region.KOLSHUSHU]        = xi.ki.KOLSHUSHU_EF_INSIGNIA,
    [xi.region.KUZOTZ]           = xi.ki.KUZOTZ_EF_INSIGNIA,
    [xi.region.LITELOR]          = xi.ki.LITELOR_EF_INSIGNIA,
    [xi.region.NORVALLEN]        = xi.ki.NORVALLEN_EF_INSIGNIA,
    [xi.region.QUFIMISLAND]      = xi.ki.QUFIM_EF_INSIGNIA,
    [xi.region.VALDEAUNIA]       = xi.ki.VALDEAUNIA_EF_INSIGNIA,
    [xi.region.VOLLBOW]          = xi.ki.VOLLBOW_EF_INSIGNIA,
    [xi.region.ZULKHEIM]         = xi.ki.ZULKHEIM_EF_INSIGNIA,
}

-----------------------------------
-- Local functions
-----------------------------------

-----------------------------------
-- Public functions
-----------------------------------

-- Dispose of every Expeditionary Force insignia the player is holding.
-- Called on a nation change, since insignias are tied to the player's old allegiance.
xi.expeditionaryForce.disposeInsigniaNationSwap = function(player)
    -- Remove all insignias
    local removed = false
    for _, ki in pairs(regionKITable) do
        if player:hasKeyItem(ki) then
            player:delKeyItem(ki)
            removed = true
        end
    end

    -- If any insignia is removed, send message and reset character variables
    if removed then
        player:messageSpecial(zones[player:getZoneID()].text.INVALID_ENSIGNIAS)
        player:setCharVar('[ExpForce]Participation', 0)
        player:setCharVar('[ExpForce]NextConquestTally', 0)
        player:setCharVar('[ExpForce]AwardCP', 0)
    end
end
