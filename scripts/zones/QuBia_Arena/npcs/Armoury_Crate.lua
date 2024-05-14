-----------------------------------
-- Area: Qu'Bia Arena
--  NPC: Armoury Crate
-----------------------------------
local entity = {}

local loot =
{
    -- BCNM Let Sleeping Dogs Die
    [522] =
    {
        {
            { itemid = xi.item.WOLF_HIDE, droprate = 1000 }, -- wolf_hide
        },

        {
            { itemid = xi.item.REVIVAL_TREE_ROOT, droprate = 1000 }, -- revival_tree_root
        },

        {
            { itemid = xi.item.NONE,            droprate = 100 }, -- nothing
            { itemid = xi.item.MANNEQUIN_HEAD,  droprate = 300 }, -- mannequin_head
            { itemid = xi.item.MANNEQUIN_BODY,  droprate = 300 }, -- mannequin_body
            { itemid = xi.item.MANNEQUIN_HANDS, droprate = 300 }, -- mannequin_hands
        },

        {
            { itemid = xi.item.NONE,                  droprate = 250 }, -- nothing
            { itemid = xi.item.SCROLL_OF_ABSORB_AGI,  droprate = 125 }, -- scroll_of_absorb-agi
            { itemid = xi.item.SCROLL_OF_ABSORB_INT,  droprate = 125 }, -- scroll_of_absorb-int
            { itemid = xi.item.SCROLL_OF_ABSORB_VIT,  droprate = 125 }, -- scroll_of_absorb-vit
            { itemid = xi.item.SCROLL_OF_ERASE,       droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI, droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_DISPEL,      droprate = 125 }, -- scroll_of_dispel
        },

        {
            { itemid = xi.item.NONE,             droprate = 100 }, -- nothing
            { itemid = xi.item.SINGERS_SHIELD,   droprate = 150 }, -- singers_shield
            { itemid = xi.item.WARLOCKS_SHIELD,  droprate = 150 }, -- warlocks_shield
            { itemid = xi.item.MAGICIANS_SHIELD, droprate = 150 }, -- magicians_shield
            { itemid = xi.item.ASHIGARU_MANTLE,  droprate = 150 }, -- ashigaru_mantle
            { itemid = xi.item.WIZARDS_MANTLE,   droprate = 150 }, -- wizards_mantle
            { itemid = xi.item.KILLER_MANTLE,    droprate = 150 }, -- killer_mantle
        },
    },

    -- BCNM Undying Promise
    [524] =
    {
        {
            { itemid = xi.item.BONE_CHIP, droprate = 1000 }, -- bone_chip
        },

        {
            { itemid = xi.item.BONE_CHIP, droprate = 1000 }, -- bone_chip
        },

        {
            { itemid = xi.item.CALVELEYS_DAGGER, droprate = 175 }, -- calveleys_dagger
            { itemid = xi.item.JENNET_SHIELD,    droprate = 175 }, -- jennet_shield
            { itemid = xi.item.JONGLEURS_DAGGER, droprate = 175 }, -- jongleurs_dagger
            { itemid = xi.item.KAGEHIDE,         droprate = 175 }, -- kagehide
            { itemid = xi.item.OHAGURO,          droprate = 175 }, -- ohaguro
            { itemid = xi.item.EBONY_LOG,        droprate = 125 }, -- ebony_log
        },

        {
            { itemid = xi.item.BEHOURD_LANCE,  droprate = 200 }, -- behourd_lance
            { itemid = xi.item.ELEGANT_SHIELD, droprate = 200 }, -- elegant_shield
            { itemid = xi.item.MUTILATOR,      droprate = 200 }, -- mutilator
            { itemid = xi.item.RAIFU,          droprate = 200 }, -- raifu
            { itemid = xi.item.TOURNEY_PATAS,  droprate = 200 }, -- tourney_patas
        },

        {
            { itemid = xi.item.CHUNK_OF_DARKSTEEL_ORE,   droprate =  60 }, -- chunk_of_darksteel_ore
            { itemid = xi.item.GOLD_INGOT,               droprate =  60 }, -- gold_ingot
            { itemid = xi.item.GOLD_BEASTCOIN,           droprate =  60 }, -- gold_beastcoin
            { itemid = xi.item.MYTHRIL_BEASTCOIN,        droprate =  60 }, -- mythril_beastcoin
            { itemid = xi.item.MYTHRIL_INGOT,            droprate =  60 }, -- mythril_ingot
            { itemid = xi.item.PLATINUM_INGOT,           droprate =  60 }, -- platinum_ingot
            { itemid = xi.item.RAM_HORN,                 droprate =  60 }, -- ram_horn
            { itemid = xi.item.SCROLL_OF_REFRESH,        droprate = 125 }, -- scroll_of_refresh
            { itemid = xi.item.RERAISER,                 droprate = 145 }, -- reraiser
            { itemid = xi.item.SCROLL_OF_UTSUSEMI_NI,    droprate = 125 }, -- scroll_of_utsusemi_ni
            { itemid = xi.item.SCROLL_OF_ICE_SPIKES,     droprate = 125 }, -- scroll_of_ice_spikes
            { itemid = xi.item.HANDFUL_OF_WYVERN_SCALES, droprate =  60 }, -- handful_of_wyvern_scales
        },

        {
            { itemid = xi.item.CORAL_FRAGMENT,       droprate =  78 }, -- coral_fragment
            { itemid = xi.item.DARKSTEEL_INGOT,      droprate =  78 }, -- darksteel_ingot
            { itemid = xi.item.DEMON_HORN,           droprate =  78 }, -- demon_horn
            { itemid = xi.item.FIRE_SPIRIT_PACT,     droprate = 125 }, -- fire_spirit_pact
            { itemid = xi.item.CHUNK_OF_GOLD_ORE,    droprate =  78 }, -- chunk_of_gold_ore
            { itemid = xi.item.MYTHRIL_INGOT,        droprate =  78 }, -- mythril_ingot
            { itemid = xi.item.PETRIFIED_LOG,        droprate =  78 }, -- petrified_log
            { itemid = xi.item.RAM_HORN,             droprate =  78 }, -- ram_horn
            { itemid = xi.item.SCROLL_OF_ABSORB_STR, droprate = 125 }, -- scroll_of_absorb-str
            { itemid = xi.item.SCROLL_OF_ERASE,      droprate = 125 }, -- scroll_of_erase
            { itemid = xi.item.SCROLL_OF_PHALANX,    droprate = 125 }, -- scroll_of_phalanx
        },

        {
            { itemid = xi.item.NONE,                  droprate = 850 }, -- nothing
            { itemid = xi.item.RAM_SKIN,              droprate =  50 }, -- ram_skin
            { itemid = xi.item.MAHOGANY_LOG,          droprate =  50 }, -- mahogany_log
            { itemid = xi.item.CHUNK_OF_PLATINUM_ORE, droprate =  50 }, -- platinum_ore
        },
    },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local battlefield = player:getBattlefield()
    if battlefield then
        xi.battlefield.HandleLootRolls(battlefield, loot[battlefield:getID()], nil, npc)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
