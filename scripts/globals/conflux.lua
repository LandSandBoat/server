-----------------------------------
-- Veridical Conflux Global
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/utils")
-----------------------------------

xi = xi or {}
xi.conflux = {}

-- Text Strings to use for formation of Mask charVars.  This could probably move to char_unlocks,
-- however!  We require more than 9 bytes to hold this information.  This means we'd still need at least
-- two values to store everything (BIGINT 8 bytes + one more smaller, or some logical grouping).

-- TODO: Move charVars to BLOB type in char_unlocks
local maskZoneNames =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = 'Konschtat',
    [xi.zone.ABYSSEA_TAHRONGI  ] = 'Tahrongi',
    [xi.zone.ABYSSEA_LA_THEINE ] = 'LaTheine',
    [xi.zone.ABYSSEA_ATTOHWA   ] = 'Attohwa',
    [xi.zone.ABYSSEA_MISAREAUX ] = 'Misareaux',
    [xi.zone.ABYSSEA_VUNKERL   ] = 'Vunkerl',
    [xi.zone.ABYSSEA_ALTEPA    ] = 'Altepa',
    [xi.zone.ABYSSEA_ULEGUERAND] = 'Uleguerand',
    [xi.zone.ABYSSEA_GRAUBERG  ] = 'Grauberg',
}

local confluxActivationCosts = { 50, 100, 150, 200, 250, 300, 350, 400 }

local confluxData =
{
    [xi.zone.ABYSSEA_KONSCHTAT] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 50, 100, 150, 200, 250, 300, 350, 400 } },
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 50, 100, 150, 200, 250, 300, 350, 400 } },
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 50, 100, 150, 200, 250, 300, 350, 400 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 50, 100, 150, 200, 250, 300, 350, 400 } },
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#00'] = { 8,  123, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
        ['Veridical_Conflux_#00'] = { 8,  123, { 200, 400, 600, 800, 1000, 1200, 1400, 1600} },
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
        ['Veridical_Conflux_#00'] = { 8,  123, { 200, 400, 600, 800, 1000, 1200, 1400, 1600 } },
    },

    [xi.zone.ABYSSEA_ALTEPA] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
    },

    [xi.zone.ABYSSEA_ULEGUERAND] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
        ['Veridical_Conflux_#08'] = { 7, 2138, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000 } },
    },

    [xi.zone.ABYSSEA_GRAUBERG] =
    {--  NPC Name                   Bit, CSID,   Cruor Costs
        ['Veridical_Conflux_#01'] = { 0, 2132, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#02'] = { 1, 2133, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#03'] = { 2, 2134, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#04'] = { 3, 2135, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#05'] = { 4, 2136, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#06'] = { 5, 2137, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#07'] = { 6, 2138, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
        ['Veridical_Conflux_#08'] = { 7, 2139, { 600, 800, 1000, 1200, 1400, 1600, 1800, 2000} },
    },
}

local function updateCruorCosts(player, confluxInfo)
    local discount = 1

    for keyItem = xi.ki.IVORY_ABYSSITE_OF_CONFLUENCE, xi.ki.INDIGO_ABYSSITE_OF_CONFLUENCE do
        if player:hasKeyItem(keyItem) then
            discount = discount - 0.2
        end
    end

    if discount < 1 then
        for i = 1, #confluxInfo[3] do
            confluxInfo[3][i] = confluxInfo[3][i] * discount
        end
    end

    return confluxInfo
end

local function packCostParameters(costData)
    local costParameters = {}

    local packedIndex = 1
    for costIndex, cruorAmount in ipairs(costData) do
        if costIndex % 2 == 0 then
            costParameters[packedIndex] = costParameters[packedIndex] + bit.lshift(cruorAmount, 16)
            packedIndex = packedIndex + 1
        else
            costParameters[packedIndex] = cruorAmount
        end
    end

    return costParameters
end

xi.conflux.confluxOnTrigger = function(player, npc)
    local npcName = npc:getName()
    local cruor = player:getCurrency("cruor")
    local maskVar = 'ConfluxMask[' .. maskZoneNames[player:getZoneID()] .. ']'
    local activatedMask = player:getCharVar(maskVar)
    local confluxInfo = updateCruorCosts(player, confluxData[player:getZoneID()][npcName])

    -- Veridical Conflux #00 is active by default.  If this isn't set in the player's
    -- activatedMask, add it and update the value here.
    if
        npcName == 'Veridical_Conflux_#00' and
        not utils.mask.getBit(activatedMask, confluxInfo[1])
    then
		player:setCharVar(maskVar, utils.mask.setBit(activatedMask, 8, true))
    end

    if utils.mask.getBit(activatedMask, confluxInfo[1]) then
        -- Player has already activated this Conflux
        local p2, p3, p4, p5 = unpack(packCostParameters(confluxInfo[3]))

        player:startEvent(confluxInfo[2], p2, p3, p4, p5, utils.mask.setBit(activatedMask, confluxInfo[1], false), 9, 1, cruor)
    else
        -- Activating the Conflux
        local activationCosts = updateCruorCosts(player, confluxActivationCosts)
        local p2, p3, p4, p5 = unpack(packCostParameters(activationCosts))

        player:startEvent(confluxInfo[2], p2, p3, p4, p5, 0, confluxInfo[1], 2, cruor)
    end
end

xi.conflux.confluxEventUpdate = function(player, csid, option)
    player:updateEvent(1, 0, 0, 0, 0, 0, 0, 0)
end

xi.conflux.confluxEventFinish = function(player, csid, option, npc)
    local maskVar = 'ConfluxMask[' .. maskZoneNames[player:getZoneID()] .. ']'
    local activatedMask = player:getCharVar(maskVar)
    local confluxInfo = updateCruorCosts(player, confluxData[player:getZoneID()][npc:getName()])

    if
        option ~= 0 and
        utils.mask.getBit(activatedMask, confluxInfo[1])
    then
        player:delCurrency("cruor", confluxInfo[3][option])
    elseif option == 1 then
        local activationCosts = updateCruorCosts(player, confluxActivationCosts)

        player:delCurrency("cruor", activationCosts[confluxInfo[1] + 1])
        player:setCharVar(maskVar, utils.mask.setBit(activatedMask, confluxInfo[1], true))
    end
end
