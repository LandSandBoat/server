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
        xi.ki.FRAGRANT_TREANT_PETAL,
        xi.ki.FETID_RAFFLESIA_STALK,
        xi.ki.DECAYING_MORBOL_TOOTH,
        xi.ki.TURBID_SLIME_OIL,
        xi.ki.VENOMOUS_PEISTE_CLAW,
        xi.ki.TATTERED_HIPPOGRYPH_WING,
        xi.ki.CRACKED_WIVRE_HORN,
        xi.ki.MUCID_AHRIMAN_EYEBALL,
    },

    [xi.zone.ABYSSEA_TAHRONGI] =
    {
        xi.ki.OVERGROWN_MANDRAGORA_FLOWER,
        xi.ki.MOSSY_ADAMANTOISE_SHELL,
        xi.ki.CHIPPED_SANDWORM_TOOTH,
        xi.ki.GORY_SCORPION_CLAW,
        xi.ki.FAT_LINED_COCKATRICE_SKIN,
        xi.ki.SODDEN_SANDWORM_HUSK,
        xi.ki.LUXURIANT_MANTICORE_MANE,
        xi.ki.STICKY_GNAT_WING,
        xi.ki.TORN_BAT_WING,
        xi.ki.VEINOUS_HECTEYES_EYELID,
    },

    [xi.zone.ABYSSEA_LA_THEINE] =
    {
        xi.ki.MARBLED_MUTTON_CHOP,
        xi.ki.BLOODIED_SABER_TOOTH,
        xi.ki.BLOOD_SMEARED_GIGAS_HELM,
        xi.ki.PELLUCID_FLY_EYE,
        xi.ki.SHIMMERING_PIXIE_PINION,
        xi.ki.WARPED_GIGAS_ARMBAND,
        xi.ki.SEVERED_GIGAS_COLLAR,
        xi.ki.DENTED_GIGAS_SHIELD,
        xi.ki.GLITTERING_PIXIE_CHOKER,
    },

    [xi.zone.ABYSSEA_ATTOHWA] =
    {
        xi.ki.BULBOUS_CRAWLER_COCOON,
        xi.ki.DISTENDED_CHIGOE_ABDOMEN,
        xi.ki.VENOMOUS_WAMOURA_FEELER,
        xi.ki.MUCID_WORM_SEGMENT,
        xi.ki.SHRIVELED_HECTEYES_STALK,
        xi.ki.CRACKED_SKELETON_CLAVICLE,
    },

    [xi.zone.ABYSSEA_MISAREAUX] =
    {
        xi.ki.CLIPPED_BIRD_WING,
        xi.ki.GLISTENING_OROBON_LIVER,
        xi.ki.GNARLED_LIZARD_NAIL,
        xi.ki.JAGGED_APKALLU_BEAK,
        xi.ki.DOFFED_POROGGO_HAT,
        xi.ki.MOLTED_PEISTE_SKIN,
    },

    [xi.zone.ABYSSEA_VUNKERL] =
    {
        xi.ki.OSSIFIED_GARGOUILLE_HAND,
        xi.ki.INGROWN_TAURUS_NAIL,
        xi.ki.IMBRUED_VAMPYR_FANG,
        xi.ki.PULSATING_SOULFLAYER_BEARD,
        xi.ki.GLOSSY_SEA_MONK_SUCKER,
    },

    -- TODO: Populate KI Values for these Zones
    [xi.zone.ABYSSEA_ALTEPA]     = { 0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = { 0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG]   = { 0, 0, 0 },
}

xi.pyxis.ki.setKeyItems = function(npc)
    local zoneId = npc:getZoneID()
    local ki = drops[zoneId][math.random(1, #drops[zoneId])]

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
