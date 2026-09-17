-----------------------------------
-- Phoenix NPC Adjustments
-- Adjusts NPCs to either hide unreleased content, or show NPCs that are purposely utilized even though OOE
-- TODO: Rework to YAML once module functionality is complete
-----------------------------------
require('modules/module_utils')
-----------------------------------
local m = Module:new('npc_visibility')

-- A shown entry carries a position because content gating zeroes it out.
local zoneEntities =
{
    Aht_Urhgan_Whitegate =
    {
        hidden =
        {
            'Giehnz',          -- Colosseum guard
            'Ryo',             -- ZNM assistant
            'Sanraku',         -- ZNM pop items and trophies
            'Sashosho',        -- stands at Gate: The Pit
            'Sorrowful_Sage',  -- Nyzul Isle assault
        },

        untargetable =
        {
            '_1e7',  -- Gate: The Colosseum
            '_1e9',  -- Gate: The Pit - entrance to The Colosseum
        },
    },

    Alzadaal_Undersea_Ruins =
    {
        hidden =
        {
            'qm_armed_gears',              -- Armed Gears (ZNM T3)
            'qm_cheese_hoarder_gigiroon',  -- Cheese Hoarder Gigiroon (ZNM T1)
            'qm_ob',                       -- Ob (ZNM T1)
            'qm_wulgaru',                  -- Wulgaru (ZNM T2)
        },
    },

    Arrapago_Reef =
    {
        hidden =
        {
            'qm1',  -- Lil'Apkallu (ZNM T1)
            'qm2',  -- Velionis (ZNM T1)
            'qm3',  -- Zareehkl the Jubilant (ZNM T2)
            'qm4',  -- Nuhn (ZNM T3)
        },
    },

    Aydeewa_Subterrane =
    {
        hidden =
        {
            'qm1',  -- Nosferatu (ZNM T3)
            'qm3',  -- Chigre (ZNM T1)
        },
    },

    Bastok_Mines =
    {
        shown =
        {
            { name = 'Linkshell_Concierge', pos = { 115.880, 1.000, -90.280 } },
        },
    },

    Behemoths_Dominion =
    {
        shown =
        {
            { name = 'qm_behemoth', pos = { -269.350, -19.778, 74.269 } },
        },
    },

    Bhaflau_Thickets =
    {
        hidden =
        {
            'qm1',  -- Lividroot Amooshah (ZNM T2)
            'qm2',  -- Dea (ZNM T3)
        },
    },

    Caedarva_Mire =
    {
        hidden =
        {
            'qm1',  -- Verdelet (ZNM T2)
            'qm2',  -- Experimental Lamia (ZNM T3)
            'qm3',  -- Mahjlaef the Paintorn (ZNM T3)
            'qm4',  -- Tyger (ZNM T4)
        },
    },

    Dragons_Aery =
    {
        shown =
        {
            { name = 'qm_fafnir', pos = { 82.326, 6.870, 42.042 } },
        },
    },

    Halvung =
    {
        hidden =
        {
            'qm2',  -- Dextrose (ZNM T2)
            'qm3',  -- Reacton (ZNM T2)
            'qm4',  -- Achamoth (ZNM T3)
        },
    },

    -- Tales' Beginning replays a skipped opening cutscene; tagged tvr upstream.
    Lower_Delkfutts_Tower =
    {
        shown =
        {
            { name = 'Tales_Beginning', pos = { 463.897, 0.038, -66.035 } },
        },
    },

    Lower_Jeuno =
    {
        shown =
        {
            { name = 'Tales_Beginning', pos = { -76.524, 0.000, -113.286 } },
        },
    },

    Mamook =
    {
        hidden =
        {
            'qm1',  -- Chamrosh (ZNM T1)
            'qm2',  -- Iriri Samariri (ZNM T2)
        },
    },

    Mount_Zhayolm =
    {
        hidden =
        {
            'qm1',  -- Brass Borer (ZNM T1)
            'qm2',  -- Claret (ZNM T1)
            'qm3',  -- Anantaboga (ZNM T2)
            'qm4',  -- Khromasoul Bhurborlor (ZNM T3)
            'qm5',  -- Sarameya (ZNM T4)
        },
    },

    Nashmau =
    {
        hidden =
        {
            'Kilusha',  -- Einherjar
        },
    },

    Norg =
    {
        shown =
        {
            { name = 'Tales_Beginning', pos = { -25.784, 1.097, -40.953 } },
        },
    },

    Northern_San_dOria =
    {
        shown =
        {
            { name = 'Linkshell_Concierge', pos = { 76.260, 0.000, 9.700 } },
        },
    },

    Upper_Jeuno =
    {
        hidden =
        {
            'Afdeen',
        },
    },

    Valley_of_Sorrows =
    {
        shown =
        {
            { name = 'qm_adamantoise', pos = { 0.895, 0.019, -35.588 } },
        },
    },

    Wajaom_Woodlands =
    {
        hidden =
        {
            'qm1',  -- Vulpangue (ZNM T1)
            'qm2',  -- Iriz Ima (ZNM T2)
            'qm3',  -- Gotoh Zha the Redolent (ZNM T3)
            'qm4',  -- Tinnin (ZNM T4)
        },
    },

    Windurst_Walls =
    {
        shown =
        {
            { name = 'Linkshell_Concierge', pos = { -220.550, 0.530, -136.810 } },
            { name = 'Tales_Beginning',     pos = { -182.561, -2.456, 143.515 } },
        },
    },
}

for zoneName, entities in pairs(zoneEntities) do
    m:addOverride(string.format('xi.zones.%s.Zone.onInitialize', zoneName), function(zone)
        super(zone)

        for _, npcName in ipairs(entities.hidden or {}) do
            for _, npc in ipairs(zone:queryEntitiesByName(npcName)) do
                npc:setStatus(xi.status.DISAPPEAR)
            end
        end

        for _, entry in ipairs(entities.shown or {}) do
            for _, npc in ipairs(zone:queryEntitiesByName(entry.name)) do
                -- Only NPCs the content gate hid, whose position it also zeroed.
                if npc:getStatus() == xi.status.DISAPPEAR then
                    npc:setPos(entry.pos[1], entry.pos[2], entry.pos[3])
                    npc:setStatus(xi.status.NORMAL)
                end
            end
        end

        for _, npcName in ipairs(entities.untargetable or {}) do
            for _, npc in ipairs(zone:queryEntitiesByName(npcName)) do
                npc:setUntargetable(true)
            end
        end
    end)
end

-- Ensure Pankration doors do not allow entry into the zone
m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs._1e9.onTrigger', function(player, npc)
end)

m:addOverride('xi.zones.Aht_Urhgan_Whitegate.npcs._1e9.onEventFinish', function(player, csid, option, npc)
end)
