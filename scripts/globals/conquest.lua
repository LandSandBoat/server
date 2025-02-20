-----------------------------------
-- Functions for Conquest system
-----------------------------------
require('scripts/globals/extravaganza')
require('scripts/globals/garrison')
require('scripts/globals/teleports')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
-----------------------------------
xi = xi or {}
xi.conquest = xi.conquest or {}

-----------------------------------
-- (LOCAL) constants
-----------------------------------

local conquestConstants =
{
    TALLY_START = 0,
    TALLY_END   = 1,
    UPDATE      = 2,
}

-----------------------------------
-- (LOCAL) expeditionary forces
-- TODO: implement this menu
-----------------------------------
--[[
local exForceMenuData =
{
    0x20006, ZULK_EF, 103, 0x000040, 20, xi.ki.ZULKHEIM_EF_INSIGNIA,
    0x20007, NORV_EF, 104, 0x000080, 25, xi.ki.NORVALLEN_EF_INSIGNIA,
    0x20009, DERF_EF, 109, 0x000200, 25, xi.ki.DERFLAND_EF_INSIGNIA,
    0x2000B, KOLS_EF, 118, 0x000800, 20, xi.ki.KOLSHUSHU_EF_INSIGNIA,
    0x2000C, ARAG_EF, 119, 0x001000, 25, xi.ki.ARAGONEU_EF_INSIGNIA,
    0x2000D, FAUR_EF, 111, 0x002000, 35, xi.ki.FAUREGANDI_EF_INSIGNIA,
    0x2000E, VALD_EF, 112, 0x004000, 40, xi.ki.VALDEAUNIA_EF_INSIGNIA,
    0x2000F, QUFI_EF, 126, 0x008000, 25, xi.ki.QUFIM_EF_INSIGNIA,
    0x20010, LITE_EF, 121, 0x010000, 35, xi.ki.LITELOR_EF_INSIGNIA,
    0x20011, KUZO_EF, 114, 0x020000, 40, xi.ki.KUZOTZ_EF_INSIGNIA,
    0x20012, VOLL_EF, 113, 0x040000, 65, xi.ki.VOLLBOW_EF_INSIGNIA,
    0x20013, ELLO_EF, 123, 0x080000, 35, xi.ki.ELSHIMO_LOWLANDS_EF_INSIGNIA,
    0x20014, ELUP_EF, 124, 0x100000, 45, xi.ki.ELSHIMO_UPLANDS_EF_INSIGNIA
}
]]--
local function getExForceAvailable(player, guardNation)
    return 0
end

local function getExForceReward(player, guardNation)
    return 0
end

-----------------------------------
-- (LOCAL) outposts
-----------------------------------

local outposts =
{
    [xi.region.RONFAURE]        = { zone = xi.zone.WEST_RONFAURE,          ki = xi.ki.RONFAURE_SUPPLIES,              cp = 10, lvl = 10, fee = 100 },
    [xi.region.ZULKHEIM]        = { zone = xi.zone.VALKURM_DUNES,          ki = xi.ki.ZULKHEIM_SUPPLIES,              cp = 30, lvl = 10, fee = 100 },
    [xi.region.NORVALLEN]       = { zone = xi.zone.JUGNER_FOREST,          ki = xi.ki.NORVALLEN_SUPPLIES,             cp = 40, lvl = 15, fee = 150 },
    [xi.region.GUSTABERG]       = { zone = xi.zone.NORTH_GUSTABERG,        ki = xi.ki.GUSTABERG_SUPPLIES,             cp = 10, lvl = 10, fee = 100 },
    [xi.region.DERFLAND]        = { zone = xi.zone.PASHHOW_MARSHLANDS,     ki = xi.ki.DERFLAND_SUPPLIES,              cp = 40, lvl = 15, fee = 150 },
    [xi.region.SARUTABARUTA]    = { zone = xi.zone.WEST_SARUTABARUTA,      ki = xi.ki.SARUTABARUTA_SUPPLIES,          cp = 10, lvl = 10, fee = 100 },
    [xi.region.KOLSHUSHU]       = { zone = xi.zone.BUBURIMU_PENINSULA,     ki = xi.ki.KOLSHUSHU_SUPPLIES,             cp = 40, lvl = 10, fee = 100 },
    [xi.region.ARAGONEU]        = { zone = xi.zone.MERIPHATAUD_MOUNTAINS,  ki = xi.ki.ARAGONEU_SUPPLIES,              cp = 40, lvl = 15, fee = 150 },
    [xi.region.FAUREGANDI]      = { zone = xi.zone.BEAUCEDINE_GLACIER,     ki = xi.ki.FAUREGANDI_SUPPLIES,            cp = 70, lvl = 35, fee = 350 },
    [xi.region.VALDEAUNIA]      = { zone = xi.zone.XARCABARD,              ki = xi.ki.VALDEAUNIA_SUPPLIES,            cp = 50, lvl = 40, fee = 400 },
    [xi.region.QUFIMISLAND]     = { zone = xi.zone.QUFIM_ISLAND,           ki = xi.ki.QUFIM_SUPPLIES,                 cp = 60, lvl = 15, fee = 150 },
    [xi.region.LITELOR]         = { zone = xi.zone.THE_SANCTUARY_OF_ZITAH, ki = xi.ki.LITELOR_SUPPLIES,               cp = 40, lvl = 25, fee = 250 },
    [xi.region.KUZOTZ]          = { zone = xi.zone.EASTERN_ALTEPA_DESERT,  ki = xi.ki.KUZOTZ_SUPPLIES,                cp = 70, lvl = 30, fee = 300 },
    [xi.region.VOLLBOW]         = { zone = xi.zone.CAPE_TERIGGAN,          ki = xi.ki.VOLLBOW_SUPPLIES,               cp = 70, lvl = 50, fee = 500 },
    [xi.region.ELSHIMOLOWLANDS] = { zone = xi.zone.YUHTUNGA_JUNGLE,        ki = xi.ki.ELSHIMO_LOWLANDS_SUPPLIES,      cp = 70, lvl = 25, fee = 250 },
    [xi.region.ELSHIMOUPLANDS]  = { zone = xi.zone.YHOATOR_JUNGLE,         ki = xi.ki.ELSHIMO_UPLANDS_SUPPLIES,       cp = 70, lvl = 35, fee = 350 },
    [xi.region.TULIA]           = { zone = xi.zone.RUAUN_GARDENS,                                                     cp = 0,  lvl = 70, fee = 500 },
    [xi.region.MOVALPOLOS]      = { zone = xi.zone.OLDTON_MOVALPOLOS,                                                 cp = 40, lvl = 25, fee = 250 },
    [xi.region.TAVNAZIANARCH]   = { zone = xi.zone.LUFAISE_MEADOWS,        ki = xi.ki.TAVNAZIAN_ARCHIPELAGO_SUPPLIES, cp = 70, lvl = 30, fee = 300 },
}

local function hasOutpost(player, region)
    local hasOP = player:hasTeleport(player:getNation(), region + 5)

    if not hasOP then
        if xi.settings.main.UNLOCK_OUTPOST_WARPS == 2 then
            hasOP = true
        elseif xi.settings.main.UNLOCK_OUTPOST_WARPS == 1 then
            hasOP = region <= xi.region.ELSHIMOUPLANDS
        end
    end

    return hasOP
end

local function setHomepointFee(player, guardNation)
    local pNation = player:getNation()
    local fee     = 0

    if
        pNation ~= guardNation and
        not xi.conquest.areAllies(pNation, guardNation)
    then
        local rank = player:getRank(player:getNation())

        if rank <= 5 then
            fee = 100 * math.pow(2, rank - 1)
        else
            fee = (800 * rank) - 2400
        end
    end

    return fee
end

local function getRegionsMask(nation)
    local mask = 0

    for region = xi.region.RONFAURE, xi.region.TAVNAZIANARCH do
        if GetRegionOwner(region) == nation then
            mask = bit.bor(mask, bit.lshift(1, region + 5)) -- Region bits start at 5th bit
        end
    end

    return mask
end

local function getAllowedTeleports(player, nation)
    local allowedTeleports = 0x3F40001F -- All outposts set (0 indicates allowed)

    if xi.settings.main.UNLOCK_OUTPOST_WARPS == 2 then
        return allowedTeleports -- Allow all outposts
    elseif xi.settings.main.UNLOCK_OUTPOST_WARPS == 1 then
        return 0x3FE0001F -- Allow all outposts except for Tulia and Tavnazia
    end

    for region = xi.region.RONFAURE, xi.region.TAVNAZIANARCH do
        if not xi.conquest.canTeleportToOutpost(player, region) then
            allowedTeleports = bit.bor(allowedTeleports, bit.lshift(1, region + 5)) -- Region bits start at 5th bit
        end
    end

    return allowedTeleports
end

-----------------------------------
-- (LOCAL) supply runs
-----------------------------------

-- produce supply quest mask for the nation based on current conquest standings
local function suppliesAvailableBitmask(player, nation)
    local mask = 0x7F00001F

    if player:getCharVar('supplyQuest_started') == VanadielUniqueDay() then
        mask = 0xFFFFFFFF -- Need to wait 1 vanadiel day
    end

    for k, v in pairs(outposts) do
        if v.ki and player:hasKeyItem(v.ki) then
            mask = -1
            break
        end
    end

    if mask ~= -1 and mask ~= 0xFFFFFFFF then
        for i = 0, 18 do
            if
                GetRegionOwner(i) ~= nation or
                i == 16 or
                i == 17 or
                (
                    i == 18 and
                    not player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED)
                )
            then
                mask = mask + 2^(i + 5)
            end
        end
    end

    return mask
end

local function areSuppliesRotten(player, npc, guardType)
    local fresh  = player:getCharVar('supplyQuest_fresh')
    local region = player:getCharVar('supplyQuest_region')
    local rotten = false
    local text   = zones[player:getZoneID()].text

    if region > 0 and fresh <= os.time() then
        rotten = true
    end

    if rotten then
        if guardType <= xi.conquest.guard.FOREIGN then
            player:showText(npc, text.CONQUEST + 40) -- 'We will dispose of those unusable supplies.'
        else
            player:showText(npc, text.CONQUEST - 1) -- 'Hmm... These supplies you have brought us are too old to be of any use.'
        end

        local ki = outposts[region].ki

        player:delKeyItem(ki)
        player:messageSpecial(text.KEYITEM_LOST, ki)
        player:setCharVar('supplyQuest_started', 0)
        player:setCharVar('supplyQuest_region', 0)
        player:setCharVar('supplyQuest_fresh', 0)
    end

    return rotten
end

local function canDeliverSupplies(player, guardNation, guardEvent, guardRegion)
    local delivered = false
    local region    = player:getCharVar('supplyQuest_region')

    if region == guardRegion and player:hasKeyItem(outposts[region].ki) then
        delivered = true
        player:startEvent(guardEvent, 16, 0, 0, 0, 1, 0, 0, 255) -- 'you have brought us supplies!'
    end

    return delivered
end

-----------------------------------
-- (LOCAL) overseers
-----------------------------------

local overseerOffsets =
{
    [xi.region.RONFAURE] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Doladepaiton, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Ballie, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- Flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- Flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Yoshihiro, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Molting Moth, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- Flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- Flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Kyanta-Pakyanta, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Tottoto, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- Flag
        { offset = 13, nation = xi.nation.WINDURST }, -- Flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- Flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- Flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Harvetour
    },
    [xi.region.ZULKHEIM] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Quanteilleron, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Prunilla, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Tsunashige, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Fighting Ant, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 13, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Nyata-Mobuta, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Tebubu, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 14, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 15, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Medicine Axe
    },
    [xi.region.NORVALLEN] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Chaplion, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Taumiale, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Takamoto, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Pure Heart, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Bubchu-Bibinchu, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Geruru, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Mionie
    },
    [xi.region.GUSTABERG] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Ennigreaud, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Quellebie, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Shigezane, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Heavy Fog, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Kuuwari-Aori, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Butsutsu, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Kuleo
    },
    [xi.region.DERFLAND] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Mesachedeau, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Ioupie, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Souun, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Sharp Tooth, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Mokto-Lankto, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Shikoko, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Tahmasp
    },
    [xi.region.SARUTABARUTA] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Naguipeillont, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Banege, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Ryokei, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Slow Axe, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Roshina-Kuleshuna, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Darumomo, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Mahien-Uhien
    },
    [xi.region.KOLSHUSHU] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Bonbavour, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Craigine, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Ishin, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Wise Turtle, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Ganemu-Punnemu, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Mashasha, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Lobho Ukipturi
    },
    [xi.region.ARAGONEU] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Chegourt, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Buliame, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Akane, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Three Steps, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Donmo-Boronmo, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Daruru, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Mushosho
    },
    [xi.region.FAUREGANDI] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Parledaire, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Leaufetie, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Akane, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Rattling Rain, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Ryunchi-Pauchi, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Chopapa, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Gueriette
    },
    [xi.region.VALDEAUNIA] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Jeantelas, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Pilcha, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Kaya, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Heavy Bear, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Magumo-Yagimo, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Tememe, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Pelogrant
    },
    [xi.region.QUFIMISLAND] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Pitoire, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Matica, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Sasa, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Singing Blade, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Tsonga-Hoponga, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Numumu, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Jiwon
    },
    [xi.region.LITELOR] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Credaurion, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Limion, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Calliope, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Dedden, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Ajimo-Majimo, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Ochocho, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Kasim
    },
    [xi.region.KUZOTZ] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Eaulevisat, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Laimeve, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Lindgard, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Daborn, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Variko-Njariko, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Sahgygy, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Sowande
    },
    [xi.region.VOLLBOW] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Salimardi, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Paise, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Sarmistha, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Dultwa, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Voranbo-Natanbo, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Orukeke, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Bright Moon
    },
    [xi.region.ELSHIMOLOWLANDS] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Zorchorevi, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Mupia, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Mahol, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Bammiro, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Uphra-Kophra, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Richacha, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Robino-Mobino
    },
    [xi.region.ELSHIMOUPLANDS] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Ilieumort, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Emila, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Mintoo, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Guddal, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Etaj-Pohtaj, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Ghantata, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Mugha Dovajaiho
    },
    [xi.region.TULIA] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- flag
        { offset =  3, nation = xi.nation.BEASTMEN }, -- flag
    },
    [xi.region.MOVALPOLOS] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- flag
        { offset =  3, nation = xi.nation.BEASTMEN }, -- flag
    },
    [xi.region.TAVNAZIANARCH] =
    {
        { offset =  0, nation = xi.nation.SANDORIA }, -- Jemmoquel, R.K.
        { offset =  7, nation = xi.nation.SANDORIA }, -- Chilaumme, R.K.
        { offset =  3, nation = xi.nation.SANDORIA }, -- flag
        { offset = 11, nation = xi.nation.SANDORIA }, -- flag
        { offset =  1, nation = xi.nation.BASTOK   }, -- Yoram, I.M.
        { offset =  8, nation = xi.nation.BASTOK   }, -- Ghost Talker, I.M.
        { offset =  4, nation = xi.nation.BASTOK   }, -- flag
        { offset = 12, nation = xi.nation.BASTOK   }, -- flag
        { offset =  2, nation = xi.nation.WINDURST }, -- Teldo-Moroldo, W.W.
        { offset =  9, nation = xi.nation.WINDURST }, -- Cotete, W.W.
        { offset =  5, nation = xi.nation.WINDURST }, -- flag
        { offset = 13, nation = xi.nation.WINDURST }, -- flag
        { offset =  6, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 14, nation = xi.nation.BEASTMEN }, -- flag
        { offset = 10, nation = xi.nation.OTHER    }, -- Jersey
    },
}

local crystals =
{
    [xi.item.FIRE_CRYSTAL]      = 12,
    [xi.item.ICE_CRYSTAL]       = 12,
    [xi.item.WIND_CRYSTAL]      = 12,
    [xi.item.EARTH_CRYSTAL]     = 12,
    [xi.item.LIGHTNING_CRYSTAL] = 12,
    [xi.item.WATER_CRYSTAL]     = 12,
    [xi.item.LIGHT_CRYSTAL]     = 16,
    [xi.item.DARK_CRYSTAL]      = 16,
    [xi.item.INFERNO_CRYSTAL]   = 12,
    [xi.item.GLACIER_CRYSTAL]   = 12,
    [xi.item.CYCLONE_CRYSTAL]   = 12,
    [xi.item.TERRA_CRYSTAL]     = 12,
    [xi.item.PLASMA_CRYSTAL]    = 12,
    [xi.item.TORRENT_CRYSTAL]   = 12,
    [xi.item.AURORA_CRYSTAL]    = 16,
    [xi.item.TWILIGHT_CRYSTAL]  = 16,
}

local expRings =
{
    [xi.item.CHARIOT_BAND] = { chargesWhenFull = 7, costPerCharge = 50  },
    [xi.item.EMPRESS_BAND] = { chargesWhenFull = 7, costPerCharge = 100 },
    [xi.item.EMPEROR_BAND] = { chargesWhenFull = 3, costPerCharge = 200 },
}

local function conquestRanking()
    -- computes part of argument 3 for gate guard events. represents the conquest standing of the 3 nations. Verified.
    return GetNationRank(xi.nation.SANDORIA) + 4 * GetNationRank(xi.nation.BASTOK) + 16 * GetNationRank(xi.nation.WINDURST)
end

xi.conquest.toggleRegionalNPCs = function(zone)
    -- Show/Hide regional NPCs
    -- If there is a draw or a 1st place Alliance, those NPCs won't be available anywhere.
    local id = zone:getID()
    if
        id == xi.zone.PORT_BASTOK or
        id == xi.zone.SOUTHERN_SAN_DORIA or
        id == xi.zone.WINDURST_WOODS
    then
        local regionalNPCNames =
        {
            'Nokkhi_Jinjahl',
            'Ominous_Cloud',
            'Valeriano',
            'Mokop-Sankop',
            'Cheh_Raihah',
            'Nalta',
            'Dahjal'
        }

        -- TODO: Do we need to worry about beastmen's rank?
        local rankings =
        {
            { GetNationRank(xi.nation.SANDORIA), xi.zone.SOUTHERN_SAN_DORIA },
            { GetNationRank(xi.nation.BASTOK), xi.zone.PORT_BASTOK },
            { GetNationRank(xi.nation.WINDURST), xi.zone.WINDURST_WOODS },
        }

        table.sort(rankings, function(a, b)
            return a[1] < b[1]
        end)

        local firstPlaceZone  = rankings[1][2]
        -- check if the first and second are both rank 1 (thus a tie)
        local firstAndSecondTie = rankings[1][1] == rankings[2][1]

        if
            firstPlaceZone == id and
            not firstAndSecondTie
        then
            print('Showing regional conquest NPCs in: ' .. zone:getName())
        else
            print('Hiding regional conquest NPCs in: ' .. zone:getName())
        end

        for _, name in pairs(regionalNPCNames) do
            local results = zone:queryEntitiesByName(name)

            for _, entity in pairs(results) do
                -- Will be the real entity if it has an X position
                if math.abs(entity:getXPos()) > 0 then
                    -- Hide all of these NPCs by default
                    entity:setStatus(xi.status.DISAPPEAR)

                    -- If there is a clear winner, and not a tie, show the NPCs
                    if
                        id == firstPlaceZone and
                        not firstAndSecondTie
                    then
                        entity:setStatus(xi.status.NORMAL)
                    end
                end
            end
        end
    end
end

local function getArg1(player, guardNation, guardType)
    local pNation = player:getNation()
    local output  = 0
    local signet  = 0
    local cipher  = xi.extravaganza.campaignActive() * 20 * 65536
    local voucher = player:hasKeyItem(xi.ki.CONQUEST_PROMOTION_VOUCHER) and 0x20000 or 0

    if guardNation == xi.nation.WINDURST then
        output = 33
    elseif guardNation == xi.nation.SANDORIA then
        output = 1
    elseif guardNation == xi.nation.BASTOK then
        output = 17
    end

    if guardNation == pNation then
        signet = 0
    else
        signet = 7
        if xi.conquest.areAllies(pNation, guardNation) then
            signet = 2^(2 - pNation)
        end
    end

    if guardNation == xi.nation.OTHER then
        output = (pNation * 16) + (3 * 256) + 65537
    else
        output = output + 256 * signet
    end

    if guardType == xi.conquest.guard.CITY then
        output = output + voucher
    end

    if guardType >= xi.conquest.guard.OUTPOST then
        output = output - 1
    end

    if output >= 1792 and guardType >= xi.conquest.guard.OUTPOST then
        output = 1808
    end

    return output + cipher
end

-- arg6 encodes a player's rank and nationality:
-- bits 1-4 encode the rank of the player (verified that bit 4 is part of the rank number so ranks could have gone up to 31.)
-- bits 5-6 seem to encode the citizenship as below. This part needs more testing and verification.

local function getArg6(player)
    return player:getRank(player:getNation()) + (player:getNation() * 32)
end

-----------------------------------
-- (LOCAL) overseer stock
-----------------------------------

---@class overseerInvComming : { [integer] : { cp: integer, lvl: integer, item: xi.item, rank: integer? } }
local overseerInvCommon =
{
    [32928] = { cp =     7, lvl =  1, item = xi.item.SCROLL_OF_INSTANT_RERAISE   },
    [32929] = { cp =    10, lvl =  1, item = xi.item.SCROLL_OF_INSTANT_WARP      },
    [32930] = { cp =  2500, lvl =  1, item = xi.item.RETURN_RING                 },
    [32931] = { cp =  9000, lvl =  1, item = xi.item.HOMING_RING                 },
    [32933] = { cp =   500, lvl =  1, item = xi.item.CHARIOT_BAND                },
    [32934] = { cp =  1000, lvl =  1, item = xi.item.EMPRESS_BAND                },
    [32935] = { cp =  2000, lvl =  1, item = xi.item.EMPEROR_BAND                },
    [32936] = { cp =  5000, lvl =  1, item = xi.item.WARP_RING                   },
    [32937] = { cp =  1000, lvl =  1, item = xi.item.CIPHER_OF_TENZENS_ALTER_EGO },
    [32938] = { cp =  1000, lvl =  1, item = xi.item.CIPHER_OF_RAHALS_ALTER_EGO  },
    [32939] = { cp =  1000, lvl =  1, item = xi.item.CIPHER_OF_KUKKIS_ALTER_EGO  },
    [32941] = { cp = 20000, lvl =  1, item = xi.item.REFINED_CHAIR_SET,           rank = 10 },
    [32942] = { cp =  1000, lvl =  1, item = xi.item.CIPHER_OF_MAKKIS_ALTER_EGO  },
}

---@class overseerInvNation : { [xi.nation] : { [integer]: { rank: integer, cp: integer, lvl: integer, item: xi.item, place: integer? } } }
local overseerInvNation =
{
    [xi.nation.SANDORIA] =
    {
        [32768] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_ARCHERS_LONGBOW          },
        [32769] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_ARCHERS_SWORD            },
        [32770] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_FOOTMANS_BANDANA         },
        [32771] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_FOOTMANS_GLOVES          },
        [32772] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_FOOTMANS_BOOTS           },
        [32773] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_ARCHERS_CESTI,            place = 2 },
        [32774] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.ROYAL_FOOTMANS_TUNIC,           place = 1 },
        [32784] = { rank =  2, cp =  2000, lvl = 18, item = xi.item.ROYAL_SPEARMANS_SPEAR          },
        [32785] = { rank =  2, cp =  2000, lvl = 10, item = xi.item.ROYAL_FOOTMANS_VEST            },
        [32786] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.ROYAL_FOOTMANS_TROUSERS        },
        [32787] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.ROYAL_SPEARMANS_HORN,           place = 2 },
        [32788] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.ROYAL_FOOTMANS_CLOGS,           place = 1 },
        [32800] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_HALBERD          },
        [32801] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_COLLAR           },
        [32802] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_HELM             },
        [32803] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_MUFFLERS         },
        [32804] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_SOLLERETS        },
        [32805] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_DAGGER,           place = 2 },
        [32806] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.ROYAL_SQUIRES_MACE,             place = 1 },
        [32807] = { rank =  3, cp =  4000, lvl =  1, item = xi.item.SAN_DORIAN_RING,                place = 1 },
        [32816] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.ROYAL_SWORDSMANS_BLADE         },
        [32817] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.ROYAL_SQUIRES_CHAINMAIL        },
        [32818] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.ROYAL_SQUIRES_BREECHES         },
        [32819] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.ROYAL_SQUIRES_ROBE,             place = 2 },
        [32820] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.ROYAL_SQUIRES_SHIELD,           place = 1 },
        [32832] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHT_ARMY_LANCE        },
        [32833] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TEMPLE_KNIGHT_ARMY_SWORD       },
        [32834] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHT_ARMY_SHIELD       },
        [32835] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TEMPLE_KNIGHT_ARMY_SHIELD      },
        [32836] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHT_ARMY_COLLAR       },
        [32837] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TEMPLE_KNIGHT_ARMY_COLLAR      },
        [32838] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHTS_MUFFLERS         },
        [32839] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHTS_SOLLERETS        },
        [32840] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHTS_BELT,             place = 2 },
        [32841] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.ROYAL_KNIGHTS_CLOAK,            place = 1 },
        [32848] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_ARMY_MANTLE              },
        [32849] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_GUARDS_COLLAR            },
        [32850] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_KNIGHTS_BASCINET         },
        [32851] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_KNIGHTS_AKETON           },
        [32852] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_KNIGHTS_CHAINMAIL,        place = 1 },
        [32853] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_KNIGHTS_BREECHES,         place = 1 },
        [32854] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_GUARDS_SHIELD,            place = 2 },
        [32855] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_GUARDS_ROD,               place = 1 },
        [32856] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_GUARDS_SWORD,             place = 1 },
        [32857] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.ROYAL_GUARDS_FLEURET,           place = 1 },
        [32864] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.TEMPLE_KNIGHTS_QUIVER          },
        [32865] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.GRAND_KNIGHTS_LANCE,            place = 2 },
        [32866] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.GRAND_KNIGHTS_RING,             place = 1 },
        [32880] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.GRAND_TEMPLE_KNIGHTS_GAUNTLETS },
        [32881] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.GRAND_TEMPLE_KNIGHTS_BANGLES,   place = 2 },
        [32882] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.GRAND_TEMPLE_KNIGHTS_COLLAR,    place = 1 },
        [32896] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.RESERVE_CAPTAINS_GREATSWORD    },
        [32897] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.RESERVE_CAPTAINS_PICK          },
        [32898] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.RESERVE_CAPTAINS_MACE,          place = 2 },
        [32899] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.RESERVE_CAPTAINS_LANCE,         place = 1 },
        [32912] = { rank = 10, cp = 56000, lvl =  1, item = xi.item.KINGDOM_AKETON,                 place = 1 },
        [32932] = {            cp =  5000, lvl =  1, item = xi.item.KINGDOM_SIGNET_STAFF           },
        [32940] = { rank = 10, cp = 10000, lvl =  1, item = xi.item.IMPERIAL_CHAIR_SET             },
    },

    [xi.nation.BASTOK] =
    {
        [32768] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_KNUCKLES            },
        [32769] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_CROSSBOW            },
        [32770] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_AXE                 },
        [32771] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_CAP                 },
        [32772] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_MITTENS             },
        [32773] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_LEGGINGS            },
        [32774] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_STAFF,               place = 2 },
        [32775] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.LEGIONNAIRES_SCYTHE,              place = 1 },
        [32784] = { rank =  2, cp =  2000, lvl = 18, item = xi.item.DECURIONS_HAMMER                 },
        [32785] = { rank =  2, cp =  2000, lvl = 10, item = xi.item.LEGIONNAIRES_HARNESS             },
        [32786] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.LEGIONNAIRES_SUBLIGAR            },
        [32787] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.DECURIONS_DAGGER,                 place = 2 },
        [32788] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.DECURIONS_SHIELD,                 place = 1 },
        [32800] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_AXE                   },
        [32801] = { rank =  3, cp =  4000, lvl = 10, item = xi.item.REPUBLICAN_BRONZE_MEDAL          },
        [32802] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_VISOR                 },
        [32803] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_SCALE_MAIL            },
        [32804] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_FINGER_GAUNTLETS      },
        [32805] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_CUISSES               },
        [32806] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_GREAVES               },
        [32807] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.CENTURIONS_SWORD,                 place = 2 },
        [32808] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.LEGIONNAIRES_CIRCLET,             place = 1 },
        [32809] = { rank =  3, cp =  4000, lvl =  1, item = xi.item.BASTOKAN_RING,                    place = 1 },
        [32816] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.JUNIOR_MUSKETEERS_TUCK           },
        [32817] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.IRON_MUSKETEERS_ARMET            },
        [32818] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.IRON_MUSKETEERS_GAUNTLETS        },
        [32819] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.IRON_MUSKETEERS_SABATONS         },
        [32820] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.IRON_MUSKETEERS_GAMBISON,         place = 2 },
        [32821] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.JUNIOR_MUSKETEERS_CHAKRAM,        place = 1 },
        [32832] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.MUSKETEERS_SWORD                 },
        [32833] = { rank =  5, cp = 16000, lvl = 30, item = xi.item.REPUBLICAN_IRON_MEDAL            },
        [32834] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.IRON_MUSKETEERS_CUIRASS          },
        [32835] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.IRON_MUSKETEERS_CUISSES          },
        [32836] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.MUSKETEERS_POLE,                  place = 2 },
        [32837] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.MUSKETEER_GUN,                    place = 1 },
        [32848] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.REPUBLICAN_MYTHRIL_MEDAL         },
        [32849] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.REPUBLICAN_ARMY_MANTLE           },
        [32850] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.MUSKETEER_COMMANDERS_FALCHION,    place = 2 },
        [32851] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.MUSKETEER_COMMANDERS_SHIELD,      place = 2 },
        [32852] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.MUSKETEER_COMMANDERS_ROD,         place = 1 },
        [32853] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.IRON_MUSKETEERS_GORGET,           place = 1 },
        [32864] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.IRON_MUSKETEERS_QUIVER           },
        [32865] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.GOLD_MUSKETEERS_UCHIGATANA,       place = 2 },
        [32866] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.GOLD_MUSKETEERS_RING,             place = 1 },
        [32880] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.PRAEFECTUSS_GLOVES               },
        [32881] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.PRESIDENTIAL_HAIRPIN,             place = 2 },
        [32882] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.REPUBLICAN_GOLD_MEDAL,            place = 1 },
        [32896] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.SENIOR_GOLD_MUSKETEERS_SCYTHE    },
        [32897] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.SENIOR_GOLD_MUSKETEERS_ROD       },
        [32898] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.SENIOR_GOLD_MUSKETEERS_AXE,       place = 2 },
        [32899] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.SENIOR_GOLD_MUSKETEERS_SCIMITAR,  place = 1 },
        [32912] = { rank = 10, cp = 56000, lvl =  1, item = xi.item.REPUBLIC_AKETON,                  place = 1 },
        [32932] = {            cp =  5000, lvl =  1, item = xi.item.REPUBLIC_SIGNET_STAFF            },
        [32940] = { rank = 10, cp = 10000, lvl =  1, item = xi.item.DECORATIVE_CHAIR_SET             },
    },

    [xi.nation.WINDURST] =
    {
        [32768] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.FREESWORDS_BOW               },
        [32769] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.FREESWORDS_CLUB              },
        [32770] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.FREESWORDS_BAGHNAKHS         },
        [32771] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.FREESWORDS_SLOPS,             place = 2 },
        [32772] = { rank =  1, cp =  1000, lvl = 10, item = xi.item.FREESWORDS_STAFF,             place = 1 },
        [32784] = { rank =  2, cp =  2000, lvl = 18, item = xi.item.MERCENARYS_POLE              },
        [32785] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_HACHIMAKI         },
        [32786] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_GI                },
        [32787] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_TEKKO             },
        [32788] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_SITABAKI          },
        [32789] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_KYAHAN            },
        [32790] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_KNIFE,             place = 2 },
        [32791] = { rank =  2, cp =  2000, lvl = 20, item = xi.item.MERCENARYS_GREATSWORD,        place = 1 },
        [32800] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_SCYTHE    },
        [32801] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_HEADGEAR  },
        [32802] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_DOUBLET   },
        [32803] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_GLOVES    },
        [32804] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_HOSE      },
        [32805] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_GAITERS   },
        [32806] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_KUKRI,     place = 2 },
        [32807] = { rank =  3, cp =  4000, lvl = 30, item = xi.item.MERCENARY_CAPTAINS_BELT,      place = 1 },
        [32808] = { rank =  3, cp =  4000, lvl =  1, item = xi.item.WINDURSTIAN_RING,             place = 1 },
        [32816] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_DAGGER        },
        [32817] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_BOOMERANG     },
        [32818] = { rank =  4, cp =  8000, lvl = 10, item = xi.item.GREEN_SCARF                  },
        [32819] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_CLOAK         },
        [32820] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_MITTS         },
        [32821] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_SLACKS        },
        [32822] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_SHOES         },
        [32823] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_SCIMITAR,      place = 2 },
        [32824] = { rank =  4, cp =  8000, lvl = 40, item = xi.item.COMBAT_CASTERS_AXE,           place = 1 },
        [32832] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_WAND,     place = 2 },
        [32833] = { rank =  5, cp = 16000, lvl = 30, item = xi.item.PAISLEY_SCARF                },
        [32834] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_HAT,      place = 2 },
        [32835] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_COAT     },
        [32836] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_CUFFS    },
        [32837] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_SLOPS    },
        [32838] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_PIGACHES },
        [32839] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_ESPADON  },
        [32840] = { rank =  5, cp = 16000, lvl = 50, item = xi.item.TACTICIAN_MAGICIANS_HOOKS,    place = 1 },
        [32848] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.CHECKERED_SCARF              },
        [32849] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.FEDERAL_ARMY_MANTLE          },
        [32850] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.WISE_WIZARDS_STAFF,           place = 2 },
        [32851] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.WISE_WIZARDS_BILBO,           place = 2 },
        [32852] = { rank =  6, cp = 24000, lvl = 55, item = xi.item.WISE_WIZARDS_ANELACE,         place = 1 },
        [32864] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.COMBAT_CASTERS_QUIVER        },
        [32865] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.PATRIARCH_PROTECTORS_SHIELD,  place = 2 },
        [32866] = { rank =  7, cp = 32000, lvl = 60, item = xi.item.PATRIARCH_PROTECTORS_RING,    place = 1 },
        [32880] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.MASTER_CASTERS_MITTS         },
        [32881] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.MASTER_CASTERS_BRACELETS,     place = 2 },
        [32882] = { rank =  8, cp = 40000, lvl = 65, item = xi.item.WINDURSTIAN_SCARF,            place = 1 },
        [32896] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.MASTER_CASTERS_BOW           },
        [32897] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.MASTER_CASTERS_POLE          },
        [32898] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.MASTER_CASTERS_BAGHNAKHS,     place = 2 },
        [32899] = { rank =  9, cp = 48000, lvl = 71, item = xi.item.MASTER_CASTERS_KNIFE,         place = 1 },
        [32912] = { rank = 10, cp = 56000, lvl =  1, item = xi.item.FEDERATION_AKETON,            place = 1 },
        [32932] = {            cp =  5000, lvl =  1, item = xi.item.FEDERATION_SIGNET_STAFF      },
        [32940] = { rank = 10, cp = 10000, lvl =  1, item = xi.item.ORNATE_STOOL_SET             },
    },
}

local titlesGranted =
{
    [0] = -- San d'Oria
    {
        [1]  = xi.title.ROYAL_ARCHER,
        [2]  = xi.title.ROYAL_SPEARMAN,
        [3]  = xi.title.ROYAL_SQUIRE,
        [4]  = xi.title.ROYAL_SWORDSMAN,
        [5]  = xi.title.ROYAL_CAVALIER,
        [6]  = xi.title.ROYAL_GUARD,
        [7]  = xi.title.GRAND_KNIGHT_OF_THE_REALM,
        [8]  = xi.title.GRAND_TEMPLE_KNIGHT,
        [9]  = xi.title.RESERVE_KNIGHT_CAPTAIN,
        [10] = xi.title.ELITE_ROYAL_GUARD,
    },
    [1] = -- Bastok
    {
        [1]  = xi.title.LEGIONNAIRE,
        [2]  = xi.title.DECURION,
        [3]  = xi.title.CENTURION,
        [4]  = xi.title.JUNIOR_MUSKETEER,
        [5]  = xi.title.SENIOR_MUSKETEER,
        [6]  = xi.title.MUSKETEER_COMMANDER,
        [7]  = xi.title.GOLD_MUSKETEER,
        [8]  = xi.title.PRAEFECTUS,
        [9]  = xi.title.SENIOR_GOLD_MUSKETEER,
        [10] = xi.title.PRAEFECTUS_CASTRORUM,
    },
    [2] = -- Windurst
    {
        [1]  = xi.title.FREESWORD,
        [2]  = xi.title.MERCENARY,
        [3]  = xi.title.MERCENARY_CAPTAIN,
        [4]  = xi.title.COMBAT_CASTER,
        [5]  = xi.title.TACTICIAN_MAGICIAN,
        [6]  = xi.title.WISE_WIZARD,
        [7]  = xi.title.PATRIARCH_PROTECTOR,
        [8]  = xi.title.CASTER_CAPTAIN,
        [9]  = xi.title.MASTER_CASTER,
        [10] = xi.title.MERCENARY_MAJOR,
    },
}

local function getStock(player, guardNation, option)
    local r = overseerInvCommon[option]

    if r == nil then
        if guardNation == xi.nation.OTHER then
            r = overseerInvNation[player:getNation()][option]
        else
            r = overseerInvNation[guardNation][option]
        end
    end

    return r
end

local function canBuyExpRing(player, item)
    local text = zones[player:getZoneID()].text

    -- check exp ring count
    if xi.settings.main.ALLOW_MULTIPLE_EXP_RINGS ~= 1 then
        for i = 15761, 15763 do
            if player:hasItem(i) then
                player:messageSpecial(text.CONQUEST + 60, 0, 0, item) -- You do not meet the requirements to purchase the <item>.
                player:messageSpecial(text.CONQUEST + 50, 0, 0, item) -- Due to its special nature, you can only purchase or recharge <item> once until the conquest results tally is performed. Also, you cannot purchase this item if a similar item is already in your possession.

                return false
            end
        end
    end

    -- one exp ring per conquest tally
    if
        xi.settings.main.BYPASS_EXP_RING_ONE_PER_WEEK ~= 1 and
        player:getCharVar('CONQUEST_RING_RECHARGE') ~= 0
    then
        player:messageSpecial(text.CONQUEST + 60, 0, 0, item)
        player:messageSpecial(text.CONQUEST + 50, 0, 0, item)

        return false
    end

    return true
end

-----------------------------------
-- (PUBLIC) conquest
-----------------------------------

xi.conquest.guard =
{
    CITY    = 1,
    FOREIGN = 2,
    OUTPOST = 3,
    BORDER  = 4,
}

xi.conquest.areAllies = function(nationA, nationB)
    return IsConquestAlliance() and
        GetNationRank(nationA) > 1 and
        GetNationRank(nationB) > 1
end

xi.conquest.outpostFee = function(player, region)
    if not hasOutpost(player, region) then
        return 0
    end

    local fee = outposts[region].fee
    if GetRegionOwner(region) == player:getNation() then
        return fee
    else
        return fee * 3
    end
end

xi.conquest.canTeleportToOutpost = function(player, region)
    local outpost = outposts[region]
    if
        outpost == nil or
        player:getMainLvl() < outpost.lvl or
        not hasOutpost(player, region)
    then
        return false
    end

    return true
end

xi.conquest.setRegionalConquestOverseers = function(region)
    local zone = outposts[region].zone

    if zone then
        local base = zones[zone].npc.OVERSEER_BASE
        local npcs = overseerOffsets[region]

        if base and npcs then

            -- update the npcs
            local owner = GetRegionOwner(region)
            for _, v in pairs(npcs) do
                local npc = GetNPCByID(base + v.offset)

                if npc then
                    if v.nation == owner then
                        npc:setStatus(xi.status.NORMAL)
                    else
                        npc:setStatus(xi.status.DISAPPEAR)
                    end

                    if v.nation == xi.nation.OTHER then
                        if owner ~= xi.nation.BEASTMEN then
                            npc:setStatus(xi.status.NORMAL)
                        else
                            npc:setStatus(xi.status.DISAPPEAR)
                        end
                    end
                end
            end
        end
    end
end

-----------------------------------
-- (PUBLIC) overseer
-----------------------------------
xi.conquest.overseerOnTrade = function(player, npc, trade, guardNation, guardType)
    if xi.garrison.onTrade(player, npc, trade, guardNation) then
        return
    end

    if player:getNation() == guardNation or guardNation == xi.nation.OTHER then
        local item           = trade:getItemId()
        local tradeConfirmed = false
        local mOffset        = zones[player:getZoneID()].text.CONQUEST

        -- DONATE CRYSTALS FOR RANK OR CONQUEST POINTS
        if guardType <= xi.conquest.guard.FOREIGN and crystals[item] then
            local pRank       = player:getRank(player:getNation())
            local pRankPoints = player:getRankPoints()
            local addPoints   = 0

            for crystalId, crystalWorth in pairs(crystals) do
                local count = trade:getItemQty(crystalId)

                if count > 0 then
                    if pRank == 1 then
                        player:showText(npc, mOffset - 7) -- 'I cannot accept crystals from someone whose rank is still 1.'
                        break
                    elseif pRankPoints == 4000 then
                        player:showText(npc, mOffset + 43) -- 'You do not need to donate any more crystals at your current rank.'
                        break
                    else
                        trade:confirmItem(crystalId, count)
                        addPoints = addPoints + count * math.floor(4000 / (player:getRank(player:getNation()) * 12 - crystalWorth))
                    end
                end
            end

            if addPoints > 0 and pRank ~= 1 and pRankPoints < 4000 then
                if pRankPoints + addPoints >= 4000 then
                    player:setRankPoints(4000)
                    player:addCP(pRankPoints + addPoints - 4000)
                    player:showText(npc, mOffset + 44) -- 'Your rank points are full. We've added the excess to your conquest points.'
                else
                    player:addRankPoints(addPoints)
                    player:showText(npc, mOffset + 45) -- 'We've awarded you rank points for the crystals you've donated.'
                end

                player:confirmTrade()
                tradeConfirmed = true
            end
        end

        -- RECHARGE EXP RING
        if not tradeConfirmed and expRings[item] and npcUtil.tradeHas(trade, item) then
            if
                xi.settings.main.BYPASS_EXP_RING_ONE_PER_WEEK == 1 or
                player:getCharVar('CONQUEST_RING_RECHARGE') == 0
            then
                local ring = expRings[item]

                -- find the item so can determine the actual charges used
                -- (if still some charges left then recharging is proportionally less CP)
                local ringItem = player:findItem(item)
                if ringItem then
                    -- by default assume all charges used and calculate CP cost for a full recharge
                    local cpCost = ring.chargesWhenFull * ring.costPerCharge

                    -- calculate the charges used (clamp to ensure no strangeness)
                    local chargesLeft = utils.clamp(ringItem:getCurrentCharges(), 0, ring.chargesWhenFull)
                    local chargesUsed = ring.chargesWhenFull - chargesLeft

                    -- player trying to recharge a full ring so notify player and exit
                    if chargesUsed == 0 then
                        player:showText(npc, mOffset + 57, item) -- 'The <item> is already fully charged.'
                        return
                    -- player has used some but not all charges so calculate the CP cost for recharge
                    elseif
                        chargesUsed > 0 and
                        chargesUsed < ring.chargesWhenFull
                    then
                        cpCost = chargesUsed * ring.costPerCharge
                    end

                    -- if enough CP then perform the recharge
                    if player:getCP() >= cpCost then
                        player:delCP(cpCost)
                        player:confirmTrade()
                        player:addItem(item)
                        player:setCharVar('CONQUEST_RING_RECHARGE', 1, NextConquestTally())
                        player:showText(npc, mOffset + 58, item, cpCost, chargesUsed) -- 'Your ring is now fully recharged.'
                    else
                        player:showText(npc, mOffset + 55, item, cpCost) -- 'You do not have the required conquest points to recharge.'
                    end
                -- could not find the player's current ring so stop attempt
                else
                    return
                end
            else
                player:showText(npc, mOffset + 56, item) -- 'Please be aware that you can only purchase or recharge <item> once during the period between each conquest results tally.
            end
        end
    end
end

xi.conquest.overseerOnTrigger = function(player, npc, guardNation, guardType, guardEvent, guardRegion)
    local pNation = player:getNation()

    if xi.garrison.onTrigger(player, npc) then
        return
    end

    -- SUPPLY RUNS
    if
        pNation == guardNation and
        areSuppliesRotten(player, npc, guardType)
    then
        -- do nothing else
    elseif
        pNation == guardNation and
        guardType >= xi.conquest.guard.OUTPOST and
        canDeliverSupplies(player, guardNation, guardEvent, guardRegion)
    then
        -- do nothing else

    -- JEUNO OVERSEERS
    elseif guardType == xi.conquest.guard.CITY and guardNation == xi.nation.OTHER then
        local a1 = getArg1(player, guardNation, guardType)
        local a3 = conquestRanking()
        local a6 = getArg6(player)
        local a7 = player:getCP()

        player:startEvent(guardEvent, a1, 0, a3, 0, 0, a6, a7, 0)

    -- CITY AND FOREIGN OVERSEERS
    elseif guardType <= xi.conquest.guard.FOREIGN then
        local a1 = getArg1(player, guardNation, guardType)
        local a2 = getExForceAvailable(player, guardNation)
        local a3 = conquestRanking()
        local a4 = suppliesAvailableBitmask(player, guardNation)
        local a5 = player:getTeleport(guardNation)
        local a6 = getArg6(player)
        local a7 = player:getCP()
        local a8 = getExForceReward(player, guardNation)

        player:startEvent(guardEvent, a1, a2, a3, a4, a5, a6, a7, a8)

    -- OUTPOST AND BORDER OVERSEERS
    elseif guardType >= xi.conquest.guard.OUTPOST then
        local a1 = getArg1(player, guardNation, guardType)
        if a1 == 1808 then -- non-allied nation
            player:startEvent(guardEvent, a1, 0, 0, 0, 0, player:getRank(player:getNation()), 0, 0)
        else
            player:startEvent(guardEvent, a1, 0, 0x3F0000, 0, 0, getArg6(player), 0, 0)
        end
    end
end

xi.conquest.overseerOnEventUpdate = function(player, csid, option, guardNation)
    local pNation = player:getNation()

    if guardNation == xi.nation.OTHER then
        guardNation = pNation
    end

    local stock = getStock(player, guardNation, option)

    if stock ~= nil then
        local pRank = GetNationRank(pNation)
        local u1    = 2 -- default: player is correct job and level to equip item
        local u2    = 0 -- default: player has enough CP for item
        local u3    = stock.item -- default: the item ID we're purchasing

        if not player:canEquipItem(stock.item, false) then -- can't equip
            u1 = 0 -- can't equip due to job
        elseif stock.lvl > player:getMainLvl() then
            u1 = 1 -- can't equip due to level
        end

        if stock.cp > player:getCP() then
            u2 = 1
        end

        if
            option >= 32933 and
            option <= 32935 and
            player:hasKeyItem(xi.ki.CONQUEST_PROMOTION_VOUCHER)
        then
            u2 = 0
        end

        local rankCheck = true
        if
            guardNation ~= xi.nation.OTHER and
            guardNation ~= pNation and
            GetNationRank(guardNation) <= pRank
        then -- buy from other nation, must be higher ranked
            rankCheck = false
        elseif
            guardNation ~= xi.nation.OTHER and
            stock.place ~= nil and
            guardNation ~= pNation
        then -- buy from other nation, cannot buy items with nation rank requirement
            rankCheck = false
        elseif stock.place ~= nil and pRank > stock.place then -- buy from own nation, check nation rank
            rankCheck = false
        end

        if rankCheck and u2 == 0 then
            player:setLocalVar('boughtItemCP', stock.item) -- set localVar for later cheat prevention
        end

        player:updateEvent(u1, u2, u3)
    end
end

-- Additional checks to ensure that the player can actually purchase the item requested from the overseer.
-- Returns price of the item if valid, -1 if invalid.
local function canPurchaseItem(player, stock, pRank, guardNation, mOffset, option)
    -- Validate stock
    if stock == nil then
        return -1
    end

    -- validate localVar (cheat protection)
    local boughtItem = player:getLocalVar('boughtItemCP')
    player:setLocalVar('boughtItemCP', 0)

    if stock.item ~= boughtItem then
        player:messageSpecial(mOffset + 61, stock.item) -- 'Your rank is too low to purchase the <item>.'
        return -1
    end

    -- validate rank
    if stock.rank and pRank < stock.rank then
        player:messageSpecial(mOffset + 61, stock.item) -- 'Your rank is too low to purchase the <item>.'
        return -1
    end

    -- validate price
    local price = stock.cp
    if
        stock.rank ~= nil and
        player:getNation() ~= guardNation and
        guardNation ~= xi.nation.OTHER
    then
        if price <= 8000 then
            price = price * 2
        else
            price = price + 8000
        end
    end

    if player:getCP() < price then
        if
            option <= 32933 and
            option >= 32935 and
            not player:hasKeyItem(xi.ki.CONQUEST_PROMOTION_VOUCHER)
        then
            player:messageSpecial(mOffset + 62, 0, 0, stock.item) -- 'You do not have enough conquest points to purchase the <item>.'
            return -1
        end
    end

    return price
end

xi.conquest.overseerOnEventFinish = function(player, csid, option, guardNation, guardType, guardRegion)
    local pNation  = player:getNation()
    local pRank    = player:getRank(pNation)
    local sRegion  = player:getCharVar('supplyQuest_region')
    local sOutpost = outposts[sRegion]
    local mOffset  = zones[player:getZoneID()].text.CONQUEST

    if xi.garrison.onEventFinish(player, csid, option, guardNation, guardType, guardRegion) then
        return
    end

    -- SIGNET
    if option == 1 then
        local duration = (pRank + GetNationRank(pNation) + 3) * 3600
        player:delStatusEffectsByFlag(xi.effectFlag.INFLUENCE, true)
        player:addStatusEffect(xi.effect.SIGNET, 0, 0, duration)
        player:messageSpecial(mOffset + 1) -- 'You've received your nation's Signet!'

        if player:getEminenceProgress(3367) then
            xi.roe.onRecordTrigger(player, 3367) -- Complete Weekly Signet, brb objective.  This might be able to move to a status effect trigger
        end

    -- BEGIN SUPPLY RUN
    elseif
        option >= 65541 and
        option <= 65565 and
        guardType <= xi.conquest.guard.FOREIGN
    then
        local region  = option - 65541
        local outpost = outposts[region]

        if outpost ~= nil then
            npcUtil.giveKeyItem(player, outpost.ki)
            player:setCharVar('supplyQuest_started', VanadielUniqueDay())
            player:setCharVar('supplyQuest_region', region)
            player:setCharVar('supplyQuest_fresh', NextConquestTally())
        end

    -- FINISH SUPPLY RUN
    elseif
        option == 2 and
        guardType >= xi.conquest.guard.OUTPOST and
        sRegion == guardRegion and
        sOutpost ~= nil and
        player:hasKeyItem(sOutpost.ki) and
        guardNation == pNation
    then
        player:delKeyItem(sOutpost.ki)
        player:addCP(sOutpost.cp)
        player:messageSpecial(mOffset) -- 'You've earned conquest points!'
        player:setCharVar('supplyQuest_started', 0)
        player:setCharVar('supplyQuest_region', 0)
        player:setCharVar('supplyQuest_fresh', 0)

        if not player:hasTeleport(guardNation, sRegion + 5) then
            player:addTeleport(guardNation, sRegion + 5)
        end

    -- SET HOMEPOINT
    elseif option == 4 then
        if player:delGil(setHomepointFee(player, guardNation)) then
            player:setHomePoint()
            player:messageSpecial(mOffset + 94) -- 'Your home point has been set.'
        else
            player:messageSpecial(mOffset + 95) -- 'You do not have enough gil to set your home point here.'
        end

    -- PURCHASE CP ITEM
    elseif option >= 32768 and option <= 32944 then
        local stock = getStock(player, guardNation, option)
        local price = canPurchaseItem(player, stock, pRank, guardNation, mOffset, option)

        if price < 0 then
            return
        end

        -- validate exp rings
        if
            option >= 32933 and
            option <= 32935 and
            not canBuyExpRing(player, stock.item)
        then
            return
        end

        -- make sale
        if npcUtil.giveItem(player, stock.item) then
            if option >= 32933 and option <= 32935 then
                player:setCharVar('CONQUEST_RING_RECHARGE', 1, NextConquestTally())

                if player:hasKeyItem(xi.ki.CONQUEST_PROMOTION_VOUCHER) then
                    player:delKeyItem(xi.ki.CONQUEST_PROMOTION_VOUCHER)

                    return
                end
            end

            player:delCP(price)
            if stock.rank ~= nil then
                player:setTitle(titlesGranted[pNation][stock.rank])
            end
        end
    end
end

-----------------------------------
-- (PUBLIC) vendor
-----------------------------------
xi.conquest.vendorOnTrigger = function(player, vendorRegion, vendorEvent)
    local pNation = player:getNation()
    local owner   = GetRegionOwner(vendorRegion)
    local nation  = 0
    local fee     = xi.conquest.outpostFee(player, vendorRegion)

    if owner == pNation then
        nation = 1
    elseif xi.conquest.areAllies(pNation, owner) then
        nation = 2
    end

    player:startEvent(vendorEvent, nation, fee, 0, fee, player:getCP(), 0, 0, 0)
end

xi.conquest.vendorOnEventUpdate = function(player, vendorRegion)
    local fee = xi.conquest.outpostFee(player, vendorRegion)

    player:updateEvent(player:getGil(), fee, 0, fee, player:getCP())
end

xi.conquest.vendorOnEventFinish = function(player, option, vendorRegion)
    local fee = xi.conquest.outpostFee(player, vendorRegion)

    if option == 1 then
        xi.shop.outpost(player)
    elseif option == 2 then
        if player:delGil(fee) then
            player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.HOME_NATION, 0, 1, 0, vendorRegion)
        end
    elseif option == 6 then
        player:delCP(fee)
        player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.HOME_NATION, 0, 1, 0, vendorRegion)
    end
end

-----------------------------------
-- (PUBLIC) outpost teleport NPC
-----------------------------------
xi.conquest.teleporterOnTrigger = function(player, teleporterNation, teleporterEvent)
    local sandyRegions     = getRegionsMask(xi.nation.SANDORIA)
    local bastokRegions    = getRegionsMask(xi.nation.BASTOK)
    local windyRegions     = getRegionsMask(xi.nation.WINDURST)
    local beastmenRegions  = getRegionsMask(xi.nation.BEASTMEN)
    local allowedTeleports = getAllowedTeleports(player, teleporterNation)
    local nationBits       = player:getNation() + bit.lshift(teleporterNation, 8)

    player:startEvent(teleporterEvent, sandyRegions, bastokRegions, windyRegions, beastmenRegions, 0, nationBits, player:getMainLvl(), allowedTeleports)
end

xi.conquest.teleporterOnEventUpdate = function(player, csid, option, teleporterEvent)
    if csid == teleporterEvent then
        local region = option - 1073741829
        local fee    = xi.conquest.outpostFee(player, region)
        local cpFee  = fee / 10

        player:updateEvent(player:getGil(), fee, 0, cpFee, player:getCP())
    end
end

xi.conquest.teleporterOnEventFinish = function(player, csid, option, teleporterEvent)
    if csid == teleporterEvent then
        -- TELEPORT WITH GIL
        if option >= 5 and option <= 23 then
            local region = option - 5
            local fee    = xi.conquest.outpostFee(player, region)

            if
                xi.conquest.canTeleportToOutpost(player, region) and
                player:delGil(fee)
            then
                player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.OUTPOST, 0, 1, 0, region)
            end

        -- TELEPORT WITH CP
        elseif option >= 1029 and option <= 1047 then
            local region = option - 1029
            local cpFee  = xi.conquest.outpostFee(player, region) / 10

            if
                xi.conquest.canTeleportToOutpost(player, region) and
                player:getCP() >= cpFee
            then
                player:delCP(cpFee)
                player:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.OUTPOST, 0, 1, 0, region)
            end
        end
    end
end

-----------------------------------
-- (PUBLIC) conquest messages
-----------------------------------
xi.conquest.sendConquestTallyStartMessage = function(player, messageBase)
    player:messageText(player, messageBase, 5)
end

-- City areas, though not technically conquest areas, should show the tally end message.
xi.conquest.sendCityConquestTallyEndMessage = function(player, messageBase, ranking, isConquestAlliance)
    -- Tallying conquest results...
    player:messageText(player, messageBase + 1, 5)

    -- Global balance of power message
    xi.conquest.sendBalanceOfPowerMessage(player, messageBase, ranking, isConquestAlliance)
end

-- Used for non city conquest areas. shows tally end message + owner of the region.
xi.conquest.sendConquestTallyEndMessage = function(player, messageBase, owner, ranking, isConquestAlliance)
    -- Tallying conquest results...
    player:messageText(player, messageBase + 1, 5)

    if owner <= 3 then
        player:messageText(player, messageBase + 2 + owner, 5) -- This region is currently under <nation> control.
    else
        player:messageText(player, messageBase + 6, 5) -- This region is currently under beastman control.
    end

    -- Global balance of power message
    xi.conquest.sendBalanceOfPowerMessage(player, messageBase, ranking, isConquestAlliance)
end

-- Helper method for sendConquestTallyUpdateMessage and sendConquestTallyEndMessage
xi.conquest.sendBalanceOfPowerMessage = function(player, messageBase, ranking, isConquestAlliance)
    local offset = 0
    if bit.band(ranking, 0x03) == 0x01 then
        offset = offset + 7 -- 7
        if bit.band(ranking, 0x30) == 0x10 then
            offset = offset + 1 -- 8
            if bit.band(ranking, 0x0C) == 0x0C then
                offset = offset + 1 -- 9
            end
        elseif bit.band(ranking, 0x0C) == 0x08 then
            offset = offset + 3 -- 10
            if bit.band(ranking, 0x30) == 0x30 then
                offset = offset + 1 -- 11
            end
        elseif bit.band(ranking, 0x0C) == 0x04 then
            offset = offset + 6 -- 13
        end
    elseif bit.band(ranking, 0x0C) == 0x04 then
        offset = offset + 15 -- 15
        if bit.band(ranking, 0x30) == 0x02 then
            offset = offset + 3 -- 18
            if bit.band(ranking, 0x03) == 0x03 then
                offset = offset + 1 -- 19
            end
        elseif bit.band(ranking, 0x30) == 0x10 then
            offset = offset + 6 -- 21
        end
    elseif bit.band(ranking, 0x30) == 0x10 then
        offset = offset + 23 -- 23
        if bit.band(ranking, 0x0C) == 0x08 then
            offset = offset + 3 -- 26
            if bit.band(ranking, 0x30) == 0x30 then
                offset = offset + 1 -- 27
            end
        end
    end

    player:messageText(player, messageBase + offset, 5) -- Global balance of power:

    if isConquestAlliance then
        if bit.band(ranking, 0x03) == 0x01 then
            player:messageText(player, messageBase + 50, 5) -- Bastok and Windurst have formed an alliance.
        elseif bit.band(ranking, 0x0C) == 0x04 then
            player:messageText(player, messageBase + 51, 5) -- San d'Oria and Windurst have formed an alliance.
        elseif bit.band(ranking, 0x30) == 0x10 then
            player:messageText(player, messageBase + 52, 5) -- San d'Oria and Bastok have formed an alliance.
        end
    end
end

xi.conquest.sendConquestTallyUpdateMessage = function(player, messageBase, owner, ranking, influence, isConquestAlliance)
    -- don't send regional influence for city zones -- nobody can gain influence here.
    if owner == 255 then
        return
    end

    if owner <= 3 then
        player:messageText(player, messageBase + 32 + owner, 5) -- This region is currently under <nation> control.
    else
        player:messageText(player, messageBase + 31, 5) -- This region is currently under beastman control.
    end

    if influence >= 64 then
        player:messageText(player, messageBase + 37, 5) -- The beastmen are on the rise.
    elseif influence == 0 then
        player:messageText(player, messageBase + 36, 5) -- All three nations are at a deadlock.
    else
        local sandoria = bit.band(influence, 0x03)
        local bastok   = bit.rshift(bit.band(influence, 0x0C), 2)
        local windurst = bit.rshift(bit.band(influence, 0x30), 4)

        player:messageText(player, messageBase + 41 - sandoria, 5) -- Regional influence: San d'Oria
        player:messageText(player, messageBase + 45 - bastok, 5)   -- Regional influence: Bastok
        player:messageText(player, messageBase + 49 - windurst, 5) -- Regional influence: Windurst
    end

    if isConquestAlliance then
        if bit.band(ranking, 0x03) == 0x01 then
            player:messageText(player, messageBase + 53, 5) -- Bastok and Windurst are currently allies.
        elseif bit.band(ranking, 0x0C) == 0x04 then
            player:messageText(player, messageBase + 54, 5) -- San d'Oria and Windurst are currently allies.
        elseif bit.band(ranking, 0x30) == 0x10 then
            player:messageText(player, messageBase + 55, 5) -- San d'Oria and Bastok are currently allies.
        end
    end
end

xi.conquest.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    -- onConquestUpdate is called for zones in city regions as well
    -- in such cases, owner and influence is undetermined, so we call a city specific method.
    local regionId = zone:getRegionID()
    if regionId > xi.region.TAVNAZIANARCH and regionId < xi.region.DYNAMIS then
        xi.conquest.onCityConquestUpdate(zone, updatetype, ranking, isConquestAlliance)
        return
    end

    local messageBase        = zones[zone:getID()].text.CONQUEST_BASE
    local players            = zone:getPlayers()

    -----------------------------------
    -- WARNING: This is iterating every player in a zone, be careful not
    --        : to put expensive operations like db reads in here!
    -----------------------------------
    for _, player in pairs(players) do
        if updatetype == conquestConstants.TALLY_START then
            xi.conquest.sendConquestTallyStartMessage(player, messageBase)

        elseif updatetype == conquestConstants.TALLY_END then
            xi.conquest.sendConquestTallyEndMessage(player, messageBase, owner, ranking, isConquestAlliance)

        elseif updatetype == conquestConstants.UPDATE then
            xi.conquest.sendConquestTallyUpdateMessage(player, messageBase, owner, ranking, influence, isConquestAlliance)
        end
    end
end

xi.conquest.onCityConquestUpdate = function(zone, updatetype, ranking, isconquestAlliance)
    local messageBase        = zones[zone:getID()].text.CONQUEST_BASE
    local players            = zone:getPlayers()

    -----------------------------------
    -- Once per zone logic
    -----------------------------------

    -- Triggers regional npc updates for city zones only
    if updatetype == conquestConstants.TALLY_END then
        xi.conquest.toggleRegionalNPCs(zone)
    end

    -----------------------------------
    -- WARNING: This is iterating every player in a zone, be careful not
    --        : to put expensive operations like db reads in here!
    -----------------------------------
    for _, player in pairs(players) do
        if updatetype == conquestConstants.TALLY_START then
            xi.conquest.sendConquestTallyStartMessage(player, messageBase)

        elseif updatetype == conquestConstants.TALLY_END then
            xi.conquest.sendCityConquestTallyEndMessage(player, messageBase, ranking, isconquestAlliance)
        end
    end
end
