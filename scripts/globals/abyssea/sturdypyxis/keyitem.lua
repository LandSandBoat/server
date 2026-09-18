-----------------------------------
-- Abyssea Sturdy Pyxis - Key item
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.ki = {}

-----------------------------------
-- drop id's for keyitems
-- use zone id as the key
-----------------------------------
local drops =
{
    [xi.zone.ABYSSEA_KONSCHTAT]  =
    {
        xi.keyItem.FRAGRANT_TREANT_PETAL,
        xi.keyItem.FETID_RAFFLESIA_STALK,
        xi.keyItem.DECAYING_MORBOL_TOOTH,
        xi.keyItem.TURBID_SLIME_OIL,
        xi.keyItem.VENOMOUS_PEISTE_CLAW,
        xi.keyItem.TATTERED_HIPPOGRYPH_WING,
        xi.keyItem.CRACKED_WIVRE_HORN,
        xi.keyItem.MUCID_AHRIMAN_EYEBALL,
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        xi.keyItem.OVERGROWN_MANDRAGORA_FLOWER,
        xi.keyItem.MOSSY_ADAMANTOISE_SHELL,
        xi.keyItem.CHIPPED_SANDWORM_TOOTH,
        xi.keyItem.GORY_SCORPION_CLAW,
        xi.keyItem.FAT_LINED_COCKATRICE_SKIN,
        xi.keyItem.SODDEN_SANDWORM_HUSK,
        xi.keyItem.LUXURIANT_MANTICORE_MANE,
        xi.keyItem.STICKY_GNAT_WING,
        xi.keyItem.TORN_BAT_WING,
        xi.keyItem.VEINOUS_HECTEYES_EYELID,
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        xi.keyItem.MARBLED_MUTTON_CHOP,
        xi.keyItem.BLOODIED_SABER_TOOTH,
        xi.keyItem.BLOOD_SMEARED_GIGAS_HELM,
        xi.keyItem.PELLUCID_FLY_EYE,
        xi.keyItem.SHIMMERING_PIXIE_PINION,
        xi.keyItem.WARPED_GIGAS_ARMBAND,
        xi.keyItem.SEVERED_GIGAS_COLLAR,
        xi.keyItem.DENTED_GIGAS_SHIELD,
        xi.keyItem.GLITTERING_PIXIE_CHOKER,
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        xi.keyItem.BULBOUS_CRAWLER_COCOON,
        xi.keyItem.DISTENDED_CHIGOE_ABDOMEN,
        xi.keyItem.VENOMOUS_WAMOURA_FEELER,
        xi.keyItem.MUCID_WORM_SEGMENT,
        xi.keyItem.SHRIVELED_HECTEYES_STALK,
        xi.keyItem.CRACKED_SKELETON_CLAVICLE,
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        xi.keyItem.CLIPPED_BIRD_WING,
        xi.keyItem.GLISTENING_OROBON_LIVER,
        xi.keyItem.GNARLED_LIZARD_NAIL,
        xi.keyItem.JAGGED_APKALLU_BEAK,
        xi.keyItem.DOFFED_POROGGO_HAT,
        xi.keyItem.MOLTED_PEISTE_SKIN,
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        xi.keyItem.OSSIFIED_GARGOUILLE_HAND,
        xi.keyItem.INGROWN_TAURUS_NAIL,
        xi.keyItem.IMBRUED_VAMPYR_FANG,
        xi.keyItem.PULSATING_SOULFLAYER_BEARD,
        xi.keyItem.GLOSSY_SEA_MONK_SUCKER,
    },

    -- TODO: Populate KI Values for these Zones
    [xi.zone.ABYSSEA_ALTEPA]     = { 0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = { 0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG]   = { 0, 0, 0 },
}

xi.pyxis.ki.setKeyItems = function(npc)
    local zoneId = npc:getZoneID()
    local ki = drops[zoneId][math.randomInt(1, #drops[zoneId])]

    npc:setLocalVar('KI', ki)
end

xi.pyxis.ki.updateEvent = function(player, npc)
    player:updateEvent(npc:getLocalVar('KI'), 0, 0, 0, 0, 0, 0, 0)
end

xi.pyxis.ki.giveKeyItem = function(player, npc)
    local keyItem = npc:getLocalVar('KI')
    local zoneId = player:getZoneID()

    if keyItem == 0 then
        player:messageSpecial(zones[zoneId].text.KEYITEM_DISAPPEARED)
        return
    elseif player:hasKeyItem(keyItem) then
        player:messageSpecial(zones[zoneId].text.ALREADY_POSSESS_KEY_ITEM)
        return
    else
        player:addKeyItem(keyItem)
        xi.pyxis.messageChest(player, zones[zoneId].text.OBTAINS_KEYITEM, keyItem, 0, 0, 0)
        npc:setLocalVar('KI', 0)
    end

    if npc:getLocalVar('KI') == 0 then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end
