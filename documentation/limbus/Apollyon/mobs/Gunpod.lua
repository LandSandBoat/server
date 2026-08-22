-----------------------------------
-- Area: Apollyon Central
--  Mob: Gunpod
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Unlike Proto-Omega, Bind lands on the Gunpod.
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.BLIND)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)

    mob:addListener('ITEM_DROPS', 'GUNPOD_ITEM_DROPS', function(mobArg, loot)
        local result = math.randomInt(1, 100)
        local group
        if result <= 25 then
            -- Apollyon Chips
            group =
            {
                { item = xi.item.SMALT_CHIP                }, -- SE Apollyon
                { item = xi.item.SMOKY_CHIP                }, -- NE Apollyon
                { item = xi.item.CHARCOAL_CHIP             }, -- SW Apollyon
                { item = xi.item.MAGENTA_CHIP              }, -- NW Apollyon
            }
        elseif result <= 50 then
            -- Crafting Materials
            group =
            {
                { item = xi.item.CHUNK_OF_DARKSTEEL_ORE    },
                { item = xi.item.CHUNK_OF_ADAMAN_ORE       },
                { item = xi.item.DARKSTEEL_INGOT           },
                { item = xi.item.DARKSTEEL_SHEET           },
                { item = xi.item.SPOOL_OF_RAINBOW_THREAD   },
                { item = xi.item.PIECE_OF_OXBLOOD          },
                { item = xi.item.HANDFUL_OF_CLOT_PLASMA    },
                { item = xi.item.LIGHT_STEEL_INGOT         },
                { item = xi.item.PONZE_OF_SHELL_POWDER     },
            }
        elseif result <= 86 then
            -- AF+1 Materials
            group =
            {
                { item = xi.item.ARGYRO_RIVET              }, -- WAR
                { item = xi.item.ANCIENT_BRASS_INGOT       }, -- MNK
                { item = xi.item.SPOOL_OF_BENEDICT_YARN    }, -- WHM
                { item = xi.item.SPOOL_OF_DIABOLIC_YARN    }, -- BLM
                { item = xi.item.SQUARE_OF_CARDINAL_CLOTH  }, -- RDM
                { item = xi.item.SPOOL_OF_LIGHT_FILAMENT   }, -- THF
                { item = xi.item.WHITE_RIVET               }, -- PLD
                { item = xi.item.BLACK_RIVET               }, -- DRK
                { item = xi.item.FETID_LANOLIN_CUBE        }, -- BST
                { item = xi.item.SQUARE_OF_BROWN_DOESKIN   }, -- BRD
                { item = xi.item.SQUARE_OF_CHARCOAL_COTTON }, -- RNG
                { item = xi.item.SHEET_OF_KUROGANE         }, -- SAM
                { item = xi.item.POT_OF_EBONY_LACQUER      }, -- NIN
                { item = xi.item.BLUE_RIVET                }, -- DRG
                { item = xi.item.SQUARE_OF_ASTRAL_LEATHER  }, -- SMN
                { item = xi.item.SQUARE_OF_FLAMESHUN_CLOTH }, -- BLU
                { item = xi.item.SQUARE_OF_CANVAS_TOILE    }, -- COR
                { item = xi.item.SQUARE_OF_CORDUROY_CLOTH  }, -- PUP
                { item = xi.item.GOLD_STUD                 }, -- DNC
                { item = xi.item.ELECTRUM_STUD             }, -- SCH
            }
        else
            -- Ancient Beastcoins
            loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.GUARANTEED, 5)
            loot:addItem(xi.item.ANCIENT_BEASTCOIN, xi.drop_rate.COMMON)
            return
        end

        loot:addGroup(xi.drop_rate.GUARANTEED, group)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
    mob:setMobMod(xi.mobMod.RUN_SPEED_MULT, 500)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local omega = GetMobByID(mob:getID() - 1)

        if omega then
            omega:setLocalVar('podDeathTime', GetSystemTime())
        end
    end
end

return entity
