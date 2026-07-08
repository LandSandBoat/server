-----------------------------------
-- Area: Rolanberry Fields
--  NPC: Saarlan
-- Legion NPC
-- !pos 242 24.395 468 110
-----------------------------------
local ID = zones[xi.zone.ROLANBERRY_FIELDS]
-----------------------------------
---@type TNpcEntity
local entity = {}

local wares =
{
    [0x0001000A] = { ki = xi.ki.LEGION_TOME_PAGE_MAXIMUS, gil = 360000 },
    [0x0001000B] = { ki = xi.ki.LEGION_TOME_PAGE_MINIMUS, gil = 180000 },

    [0x00000002] = { item = xi.item.GAIARDAS_RING,   lp = 1000 },
    [0x00010002] = { item = xi.item.GAUBIOUS_RING,   lp = 1000 },
    [0x00020002] = { item = xi.item.CALOUSSU_RING,   lp = 1000 },
    [0x00030002] = { item = xi.item.NANGER_RING,     lp = 1000 },
    [0x00040002] = { item = xi.item.SOPHIA_RING,     lp = 1000 },
    [0x00050002] = { item = xi.item.QUIES_RING,      lp = 1000 },
    [0x00060002] = { item = xi.item.CYNOSURE_RING,   lp = 1000 },
    [0x00070002] = { item = xi.item.AMBUSCADE_RING,  lp = 1000 },
    [0x00080002] = { item = xi.item.VENEFICIUM_RING, lp = 1000 },

    [0x00090002] = { item = xi.item.CALMA_ARMET,       lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_LOFTY   },
    [0x000A0002] = { item = xi.item.MUSTELA_MASK,      lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_LOFTY   },
    [0x000B0002] = { item = xi.item.MAGAVAN_BERET,     lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_LOFTY   },
    [0x000C0002] = { item = xi.item.CALMA_GAUNTLETS,   lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_MIRED   },
    [0x000D0002] = { item = xi.item.MUSTELA_GLOVES,    lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_MIRED   },
    [0x000E0002] = { item = xi.item.MAGAVAN_MITTS,     lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_MIRED   },
    [0x000F0002] = { item = xi.item.CALMA_HOSE,        lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_SOARING },
    [0x00100002] = { item = xi.item.MUSTELA_BRAIS,     lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_SOARING },
    [0x00110002] = { item = xi.item.MAGAVAN_SLOPS,     lp = 4500,  title = xi.title.SUBJUGATOR_OF_THE_SOARING },
    [0x00120002] = { item = xi.item.CALMA_LEGGINGS,    lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x00130002] = { item = xi.item.MUSTELA_BOOTS,     lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x00140002] = { item = xi.item.MAGAVAN_CLOGS,     lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x00150002] = { item = xi.item.CALMA_BREASTPLATE, lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE     },
    [0x00160002] = { item = xi.item.MUSTELA_HARNESS,   lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE     },
    [0x00170002] = { item = xi.item.MAGAVAN_FROCK,     lp = 10000, title = xi.title.LEGENDARY_LEGIONNAIRE     },
    [0x00180002] = { item = xi.item.CORYBANT_PEARL,    lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_LOFTY   },
    [0x00190002] = { item = xi.item.SAVIESA_PEARL,     lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_MIRED   },
    [0x001A0002] = { item = xi.item.OUESK_PEARL,       lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_SOARING },
    [0x001B0002] = { item = xi.item.BELATZ_PEARL,      lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_SOARING },
    [0x001C0002] = { item = xi.item.CYTHEREA_PEARL,    lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x001D0002] = { item = xi.item.MYRDDIN_PEARL,     lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x001E0002] = { item = xi.item.PUISSANT_PEARL,    lp = 3000,  title = xi.title.SUBJUGATOR_OF_THE_VEILED  },
    [0x001F0002] = { item = xi.item.DHANURVEDA_RING,   lp = 6000,  title = xi.title.LEGENDARY_LEGIONNAIRE     },
    [0x00200002] = { item = xi.item.PROVOCARE_RING,    lp = 6000,  title = xi.title.LEGENDARY_LEGIONNAIRE     },
    [0x00210002] = { item = xi.item.MEDIATORS_RING,    lp = 6000,  title = xi.title.LEGENDARY_LEGIONNAIRE     },
}

entity.onTrigger = function(player, npc)
    if player:getCharVar('LegionStatus') == 0 then
        player:startEvent(8004)
    elseif player:getCharVar('LegionStatus') == 1 then
        local maximus = player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MAXIMUS) and 1 or 0
        local minimus = player:hasKeyItem(xi.ki.LEGION_TOME_PAGE_MINIMUS) and 1 or 0

        -- TODO: Table these and iterate
        local title =
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_LOFTY) and 1 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_MIRED) and 2 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_SOARING) and 4 or 0) +
            (player:hasTitle(xi.title.SUBJUGATOR_OF_THE_VEILED) and 8 or 0) +
            (player:hasTitle(xi.title.LEGENDARY_LEGIONNAIRE) and 16 or 0)

        player:startEvent(8005, 0, title, maximus, player:getCurrency('legion_point'), minimus)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 8004 then
        player:setCharVar('LegionStatus', 1)
    elseif csid == 8005 then
        local ware = wares[option]

        if ware then
            -- can player afford this item?
            local afford = false

            if ware.gil then
                if player:getGil() >= ware.gil then
                    afford = true
                else
                    player:messageSpecial(ID.text.NOT_ENOUGH_GIL)
                end
            elseif ware.lp then
                if player:getCurrency('legion_point') >= ware.lp then
                    afford = true
                else
                    player:messageSpecial(ID.text.LACK_LEGION_POINTS)
                end
            end

            -- if player can afford, and has the required title, attempt to give them the item/ki
            local received = false

            if afford and (not ware.title or player:hasTitle(ware.title)) then
                if ware.item and npcUtil.giveItem(player, ware.item) then
                    received = true
                elseif ware.ki and npcUtil.giveKeyItem(player, ware.ki) then
                    received = true
                end
            end

            -- if they received the item/ki, make the payment
            if received then
                if ware.gil then
                    player:delGil(ware.gil)
                elseif ware.lp then
                    player:delCurrency('legion_point', ware.lp)
                end
            end
        end
    end
end

return entity
