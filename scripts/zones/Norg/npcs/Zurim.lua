-----------------------------------
-- Area: Norg
--  NPC: Zurim
-----------------------------------
---@type TNpcEntity
local entity = {}

local domainInvasionItems =
{
    [1] = -- initial page
    {
        [1] = -- subpage
        {
            [1] = { item = xi.item.ESCHALIXIR_P2, cost = 10 },
            [2] = { item = xi.item.FRAYED_SACK_OF_FECUNDITY, cost = 10 },
            [3] = { item = xi.item.FRAYED_SACK_OF_PLENTY, cost = 10 },
            [4] = { item = xi.item.FRAYED_SACK_OF_OPULENCE, cost = 10 },
        },
    },
    [2] =
    {
        [1] =
        {
            [1] = { item = xi.item.HERVOR_GALEA, cost = 40 },
            [2] = { item = xi.item.HERVOR_HAUBERT, cost = 40 },
            [3] = { item = xi.item.HERVOR_MOUFFLES, cost = 40 },
            [4] = { item = xi.item.HERVOR_BRAYETTES, cost = 40 },
            [5] = { item = xi.item.HERVOR_SOLLERETS, cost = 40 },
            [6] = { item = xi.item.HEIDREK_MASK, cost = 40 },
            [7] = { item = xi.item.HEIDREK_HARNESS, cost = 40 },
            [8] = { item = xi.item.HEIDREK_GLOVES, cost = 40 },
            [9] = { item = xi.item.HEIDREK_BRAIS, cost = 40 },
            [10] = { item = xi.item.HEIDREK_BOOTS, cost = 40 },
            [11] = { item = xi.item.ANGANTYR_BERET, cost = 40 },
            [12] = { item = xi.item.ANGANTYR_ROBE, cost = 40 },
            [13] = { item = xi.item.ANGANTYR_MITTENS, cost = 40 },
            [14] = { item = xi.item.ANGANTYR_TIGHTS, cost = 40 },
            [15] = { item = xi.item.ANGANTYR_BOOTS, cost = 40 },
        },
    },
    [3] =
    {
        [1] =
        {
            [1] = { item = xi.item.PAIR_OF_VOLUSPA_KNUCKLES, cost = 80 },
            [2] = { item = xi.item.VOLUSPA_KNIFE, cost = 80 },
            [3] = { item = xi.item.VOLUSPA_SWORD, cost = 80 },
            [4] = { item = xi.item.VOLUSPA_BLADE, cost = 80 },
            [5] = { item = xi.item.VOLUSPA_AXE, cost = 80 },
            [6] = { item = xi.item.VOLUSPA_CHOPPER, cost = 80 },
            [7] = { item = xi.item.VOLUSPA_SCYTHE, cost = 80 },
            [8] = { item = xi.item.VOLUSPA_LANCE, cost = 80 },
            [9] = { item = xi.item.VOLUSPA_KATANA, cost = 80 },
            [10] = { item = xi.item.VOLUSPA_TACHI, cost = 80 },
            [11] = { item = xi.item.VOLUSPA_HAMMER, cost = 80 },
            [12] = { item = xi.item.VOLUSPA_POLE, cost = 80 },
            [13] = { item = xi.item.VOLUSPA_BOW, cost = 80 },
            [14] = { item = xi.item.VOLUSPA_GUN, cost = 80 },
            [15] = { item = xi.item.VOLUSPA_GRIP, cost = 80 },
            [16] = { item = xi.item.VOLUSPA_SHIELD, cost = 80 },
        },
        [2] =
        {
            [1] = { item = xi.item.VOLUSPA_QUIVER, cost = 80 },
            [2] = { item = xi.item.VOLUSPA_BOLT_QUIVER, cost = 80 },
            [3] = { item = xi.item.VOLUSPA_BULLET_POUCH, cost = 80 },
            [4] = { item = xi.item.DATE_SHURIKEN_POUCH, cost = 80 },
        },
    },
    [4] =
    {
        [1] =
        {
            [1] = { item = xi.item.SANCTITY_NECKLACE, cost = 100 },
            [2] = { item = xi.item.GISHDUBAR_SASH, cost = 100 },
            [3] = { item = xi.item.EABANI_EARRING, cost = 100 },
            [4] = { item = xi.item.ETANA_RING, cost = 100 },
            [5] = { item = xi.item.IZDUBAR_MANTLE, cost = 100 },
            [6] = { item = xi.item.SOLEMNITY_CAPE, cost = 100 },
        },
    },
    [5] =
    {
        [1] =
        {
            [1] = { item = xi.item.INSTIGATOR, cost = 200 },
            [2] = { item = xi.item.HAMMERFISTS, cost = 200 },
            [3] = { item = xi.item.QUELLER_ROD, cost = 200 },
            [4] = { item = xi.item.LATHI, cost = 200 },
            [5] = { item = xi.item.EMISSARY, cost = 200 },
            [6] = { item = xi.item.SHIJO, cost = 200 },
            [7] = { item = xi.item.NIXXER, cost = 200 },
            [8] = { item = xi.item.DEATHBANE, cost = 200 },
            [9] = { item = xi.item.SKULLRENDER, cost = 200 },
            [10] = { item = xi.item.KALI, cost = 200 },
            [11] = { item = xi.item.VIJAYA_BOW, cost = 200 },
            [12] = { item = xi.item.ICHIGOHITOFURI, cost = 200 },
            [13] = { item = xi.item.AIZUSHINTOGO, cost = 200 },
            [14] = { item = xi.item.RHOMPHAIA, cost = 200 },
            [15] = { item = xi.item.ESPIRITUS, cost = 200 },
            [16] = { item = xi.item.IRIS, cost = 200 },
        },
        [2] =
        {
            [1] = { item = xi.item.COMPENSATOR, cost = 200 },
            [2] = { item = xi.item.MIDNIGHTS, cost = 200 },
            [3] = { item = xi.item.ENCHUFLA, cost = 200 },
            [4] = { item = xi.item.AKADEMOS, cost = 200 },
            [5] = { item = xi.item.SOLSTICE, cost = 200 },
            [6] = { item = xi.item.BIDENHANDER, cost = 200 },
        },
    },
    [6] =
    {
        [1] =
        {
            [1] = { item = xi.item.TRITON_ABJURATION_HEAD, cost = 400 },
            [2] = { item = xi.item.TRITON_ABJURATION_BODY, cost = 400 },
            [3] = { item = xi.item.TRITON_ABJURATION_HANDS, cost = 400 },
            [4] = { item = xi.item.TRITON_ABJURATION_LEGS, cost = 400 },
            [5] = { item = xi.item.TRITON_ABJURATION_FEET, cost = 400 },
            [6] = { item = xi.item.BUSHIN_ABJURATION_HEAD, cost = 400 },
            [7] = { item = xi.item.BUSHIN_ABJURATION_BODY, cost = 400 },
            [8] = { item = xi.item.BUSHIN_ABJURATION_HANDS, cost = 400 },
            [9] = { item = xi.item.BUSHIN_ABJURATION_LEGS, cost = 400 },
            [10] = { item = xi.item.BUSHIN_ABJURATION_FEET, cost = 400 },
            [11] = { item = xi.item.VALE_ABJURATION_HEAD, cost = 400 },
            [12] = { item = xi.item.VALE_ABJURATION_BODY, cost = 400 },
            [13] = { item = xi.item.VALE_ABJURATION_HANDS, cost = 400 },
            [14] = { item = xi.item.VALE_ABJURATION_LEGS, cost = 400 },
            [15] = { item = xi.item.VALE_ABJURATION_FEET, cost = 400 },
            [16] = { item = xi.item.GROVE_ABJURATION_HEAD, cost = 400 },
        },
        [2] =
        {
            [1] = { item = xi.item.GROVE_ABJURATION_BODY, cost = 400 },
            [2] = { item = xi.item.GROVE_ABJURATION_HANDS, cost = 400 },
            [3] = { item = xi.item.GROVE_ABJURATION_LEGS, cost = 400 },
            [4] = { item = xi.item.GROVE_ABJURATION_FEET, cost = 400 },
            [5] = { item = xi.item.ABYSSAL_ABJURATION_HEAD, cost = 400 },
            [6] = { item = xi.item.ABYSSAL_ABJURATION_BODY, cost = 400 },
            [7] = { item = xi.item.ABYSSAL_ABJURATION_HANDS, cost = 400 },
            [8] = { item = xi.item.ABYSSAL_ABJURATION_LEGS, cost = 400 },
            [9] = { item = xi.item.ABYSSAL_ABJURATION_FEET, cost = 400 },
            [10] = { item = xi.item.SHINRYU_ABJURATION_HEAD, cost = 400 },
            [11] = { item = xi.item.SHINRYU_ABJURATION_BODY, cost = 400 },
            [12] = { item = xi.item.SHINRYU_ABJURATION_HANDS, cost = 400 },
            [13] = { item = xi.item.SHINRYU_ABJURATION_LEGS, cost = 400 },
            [14] = { item = xi.item.SHINRYU_ABJURATION_FEET, cost = 400 },
            [15] = { item = xi.item.CRONIAN_ABJURATION_HEAD, cost = 400 },
            [16] = { item = xi.item.CRONIAN_ABJURATION_BODY, cost = 400 },
        },
        [3] =
        {
            [1] = { item = xi.item.CRONIAN_ABJURATION_HANDS, cost = 400 },
            [2] = { item = xi.item.CRONIAN_ABJURATION_LEGS, cost = 400 },
            [3] = { item = xi.item.CRONIAN_ABJURATION_FEET, cost = 400 },
            [4] = { item = xi.item.AREAN_ABJURATION_HEAD, cost = 400 },
            [5] = { item = xi.item.AREAN_ABJURATION_BODY, cost = 400 },
            [6] = { item = xi.item.AREAN_ABJURATION_HANDS, cost = 400 },
            [7] = { item = xi.item.AREAN_ABJURATION_LEGS, cost = 400 },
            [8] = { item = xi.item.AREAN_ABJURATION_FEET, cost = 400 },
            [9] = { item = xi.item.JOVIAN_ABJURATION_HEAD, cost = 400 },
            [10] = { item = xi.item.JOVIAN_ABJURATION_BODY, cost = 400 },
            [11] = { item = xi.item.JOVIAN_ABJURATION_HANDS, cost = 400 },
            [12] = { item = xi.item.JOVIAN_ABJURATION_LEGS, cost = 400 },
            [13] = { item = xi.item.JOVIAN_ABJURATION_FEET, cost = 400 },
            [14] = { item = xi.item.VENERIAN_ABJURATION_HEAD, cost = 400 },
            [15] = { item = xi.item.VENERIAN_ABJURATION_BODY, cost = 400 },
            [16] = { item = xi.item.VENERIAN_ABJURATION_HANDS, cost = 400 },
        },
                [4] =
                    {
            [1] = { item = xi.item.VENERIAN_ABJURATION_LEGS, cost = 400 },
            [2] = { item = xi.item.VENERIAN_ABJURATION_FEET, cost = 400 },
            [3] = { item = xi.item.CYLLENIAN_ABJURATION_HEAD, cost = 400 },
            [4] = { item = xi.item.CYLLENIAN_ABJURATION_BODY, cost = 400 },
            [5] = { item = xi.item.CYLLENIAN_ABJURATION_HANDS, cost = 400 },
            [6] = { item = xi.item.CYLLENIAN_ABJURATION_LEGS, cost = 400 },
            [7] = { item = xi.item.CYLLENIAN_ABJURATION_FEET, cost = 400 },
                    },
    },
    [7] =
    {
        [1] =
        {
            [1] = { item = xi.item.HRETHA_EARRING, cost = 600 },
            [2] = { item = xi.item.RAN_EARRING, cost = 600 },
            [3] = { item = xi.item.FORESTI_EARRING, cost = 600 },
            [4] = { item = xi.item.HERMODR_EARRING, cost = 600 },
            [5] = { item = xi.item.SAXNOT_EARRING, cost = 600 },
            [6] = { item = xi.item.MEILI_EARRING, cost = 600 },
            [7] = { item = xi.item.MIMIR_EARRING, cost = 600 },
            [8] = { item = xi.item.VOR_EARRING, cost = 600 },
            [9] = { item = xi.item.ILMR_EARRING, cost = 600 },
            [10] = { item = xi.item.MANI_EARRING, cost = 600 },
            [11] = { item = xi.item.LODURR_EARRING, cost = 600 },
            [12] = { item = xi.item.NJORDR_EARRING, cost = 600 },
            [13] = { item = xi.item.BRAGI_EARRING, cost = 600 },
            [14] = { item = xi.item.DELLINGR_EARRING, cost = 600 },
            [15] = { item = xi.item.GERSEMI_EARRING, cost = 600 },
            [16] = { item = xi.item.HNOSS_EARRING, cost = 600 },
        },
        [2] =
        {
            [1] = { item = xi.item.GNA_EARRING, cost = 600 },
            [2] = { item = xi.item.FULLA_EARRING, cost = 600 },
        },
    },
    [8] =
    {
        [1] =
        {
            [1] = { item = xi.item.CONDEMNERS, cost = 800 },
            [2] = { item = xi.item.SKINFLAYER, cost = 800 },
            [3] = { item = xi.item.COLADA, cost = 800 },
            [4] = { item = xi.item.ZULFIQAR, cost = 800 },
            [5] = { item = xi.item.DIGIRBALAG, cost = 800 },
            [6] = { item = xi.item.AGANOSHE, cost = 800 },
            [7] = { item = xi.item.REIENKYO, cost = 800 },
            [8] = { item = xi.item.OBSCHINE, cost = 800 },
            [9] = { item = xi.item.KANARIA, cost = 800 },
            [10] = { item = xi.item.UMARU, cost = 800 },
            [11] = { item = xi.item.GADA, cost = 800 },
            [12] = { item = xi.item.GRIOAVOLR, cost = 800 },
            [13] = { item = xi.item.TELLER, cost = 800 },
            [14] = { item = xi.item.HOLLIDAY, cost = 800 },
            [15] = { item = xi.item.ODYSSEAN_HELM, cost = 800 },
            [16] = { item = xi.item.ODYSSEAN_CHESTPLATE, cost = 800 },
        },
        [2] =
        {
            [1] = { item = xi.item.ODYSSEAN_GAUNTLETS, cost = 800 },
            [2] = { item = xi.item.ODYSSEAN_CUISSES, cost = 800 },
            [3] = { item = xi.item.ODYSSEAN_GREAVES, cost = 800 },
            [4] = { item = xi.item.VALOROUS_MASK, cost = 800 },
            [5] = { item = xi.item.VALOROUS_MAIL, cost = 800 },
            [6] = { item = xi.item.VALOROUS_MITTS, cost = 800 },
            [7] = { item = xi.item.VALOROUS_HOSE, cost = 800 },
            [8] = { item = xi.item.VALOROUS_GREAVES, cost = 800 },
            [9] = { item = xi.item.HERCULEAN_HELM, cost = 800 },
            [10] = { item = xi.item.HERCULEAN_VEST, cost = 800 },
            [11] = { item = xi.item.HERCULEAN_GLOVES, cost = 800 },
            [12] = { item = xi.item.HERCULEAN_TROUSERS, cost = 800 },
            [13] = { item = xi.item.HERCULEAN_BOOTS, cost = 800 },
            [14] = { item = xi.item.CHIRONIC_HAT, cost = 800 },
            [15] = { item = xi.item.CHIRONIC_DOUBLET, cost = 800 },
            [16] = { item = xi.item.CHIRONIC_GLOVES, cost = 800 },
        },
        [3] =
        {
            [1] = { item = xi.item.CHIRONIC_HOSE, cost = 800 },
            [2] = { item = xi.item.CHIRONIC_SLIPPERS, cost = 800 },
            [3] = { item = xi.item.MERLINIC_HOOD, cost = 800 },
            [4] = { item = xi.item.MERLINIC_JUBBAH, cost = 800 },
            [5] = { item = xi.item.MERLINIC_DASTANAS, cost = 800 },
            [6] = { item = xi.item.MERLINIC_SHALWAR, cost = 800 },
            [7] = { item = xi.item.MERLINIC_CRACKOWS, cost = 800 },
        },
    },
    [9] =
    {
        [1] =
        {
            [1] = { item = xi.item.HAUKSBOK_ARROW, cost = 1000 },
            [2] = { item = xi.item.HAUKSBOK_BOLT, cost = 1000 },
            [3] = { item = xi.item.HAUKSBOK_BULLET, cost = 1000 },
            [4] = { item = xi.item.VOLUSPA_TATHLUM, cost = 1000 },
            [5] = { item = xi.item.YNGVI_CHOKER, cost = 1000 },
            [6] = { item = xi.item.THRUD_EARRING, cost = 1000 },
            [7] = { item = xi.item.ODR_EARRING, cost = 1000 },
            [8] = { item = xi.item.SNOTRA_EARRING, cost = 1000 },
            [9] = { item = xi.item.SJOFN_EARRING, cost = 1000 },
            [10] = { item = xi.item.BEYLA_EARRING, cost = 1000 },
            [11] = { item = xi.item.TUISTO_EARRING, cost = 1000 },
            [12] = { item = xi.item.NEHALENNIA_EARRING, cost = 1000 },
            [13] = { item = xi.item.DREKI_RING, cost = 1000 },
            [14] = { item = xi.item.ASK_SASH, cost = 1000 },
            [15] = { item = xi.item.EMBLA_SASH, cost = 1000 },
            [16] = { item = xi.item.AUDUMBLA_SASH, cost = 1000 },
        },
    },
    [10] =
    {
        [1] =
        {
            [1] = { item = xi.item.PILE_OF_WYRM_ASH, cost = 1200 },
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local domainInvPoints = player:getCurrency('domain_points')

    player:startEvent(9512, domainInvPoints)
end

entity.onEventUpdate = function(player, csid, option, npc)
    local itemPage = bit.band(bit.rshift(option, 2), 0x0F) + 1
    local itemSubPage = bit.band(bit.rshift(option, 10), 0x0F) + 1
    local itemSelected = bit.band(bit.rshift(option, 6), 0x0F) + 1
    local domainInvPurchase = domainInvasionItems[itemPage][itemSubPage][itemSelected]
    local domainInvPoints = player:getCurrency('domain_points')

    if npcUtil.giveItem(player, { { domainInvPurchase.item, 1 } }) then
        player:delCurrency('domain_points', domainInvPurchase.cost)
    end

    player:updateEvent(domainInvPoints - domainInvPurchase.cost)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
