-----------------------------------
-- Chocobo Raising
-- Dedicated to "Friend" the Chocobo. RIP.
--
-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/detail.html
-- https://ffxiclopedia.fandom.com/wiki/Category:Chocobo_Raising
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
-- https://ffxiclopedia.fandom.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://ffxi.gamerescape.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://www.ffxionline.com/forum/ffxi-game-related/crafting-synthesis/chocobo-raising-racing-and-digging/63439-chocobo-color-to-egg-stats-fact
-- https://www.ffxiah.com/forum/topic/32770/ninians-guide-to-chocobo-raising-v2/
-- https://docs.google.com/spreadsheets/d/1LluCnhI_LTvxW-Q6X6R2i-_jL9TABEbKcGPBMZOOlYU/edit#gid=0
-- https://ffxiclopedia.fandom.com/wiki/Carnivors_Guide_to_Chocobo_Breeding
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising/Go_on_a_Walk
--
-- VCS Chocobo Trainers
-- San d’Oria: Hantileon : !pos -2.675 -0.100 -105.287 230
-- Bastok: Zopago        : !pos 51.706 -0.126 -109.065 234
-- Windurst: Pulonono    : !pos 130.124 -6.35 -119.341 241
--
-- Eggs
-- NOTE: Purchased eggs and eggs from ISNM have nothing in their exdata!
-- Purchased/quested:
-- CHOCOBO_EGG_FAINTLY_WARM  : !additem 2312
-- CHOCOBO_EGG_SLIGHTLY_WARM : !additem 2314
-- CHOCOBO_EGG_A_BIT_WARM    : !additem 2317
-- ISNM:
-- CHOCOBO_EGG_A_LITTLE_WARM : !additem 2318
-- CHOCOBO_EGG_SOMEWHAT_WARM : !additem 2319
-----------------------------------
require("scripts/globals/items")
require("scripts/globals/settings")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/chocobo_names")
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.chocoState = xi.chocoboRaising.chocoState or {}

-----------------------------------
-- Constants & Lookups
-----------------------------------

-- TODO: Remove the duplication for walk CSs
local csidTable =
{
    -- { intro csid, main csid, trading csid, rejection csid, chicks owner csid, short walk csid, medium walk csid, long walk csid, watch csid, debug }
    [xi.zone.SOUTHERN_SAN_DORIA] = { 817, 823, 826, 831, 852, 298, 299, 300, 304, 862 }, -- Hantileon
    [xi.zone.BASTOK_MINES]       = { 508, 509, 512, 515, 542, 554, 555, 556, 560, 558 }, -- Zopago
    [xi.zone.WINDURST_WOODS]     = { 741, 742, 745, 748, 766, 810, 811, 812, 816, 773 }, -- Pulonono
}
utils.unused(csidTable)

xi.chocoboRaising.onTradeVCSTrainer = function(player, npc, trade)
end

xi.chocoboRaising.onTriggerVCSTrainer = function(player, npc)
end

xi.chocoboRaising.onEventUpdateVCSTrainer = function(player, csid, option)
end

xi.chocoboRaising.onEventFinishVCSTrainer = function(player, csid, option)
end
