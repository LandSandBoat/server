-----------------------------------
-- Tables defining diferent elemental caracteristics.
-- Ordered by element ID.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.element = xi.combat.element or {}
-----------------------------------
-- Element order = 1:Fire, 2:Ice, 3:Air, 4:Earth, 5:Thunder, 6:Water, 7:Light, 8:Dark
-----------------------------------
-- 8 elements table.
-----------------------------------
-- Weak day elements. Because the strong one is obvious.
xi.combat.element.weakDay             = { xi.day.WATERSDAY,          xi.day.FIRESDAY,          xi.day.ICEDAY,             xi.day.WINDSDAY,            xi.day.EARTHSDAY,               xi.day.LIGHTNINGDAY,        xi.day.DARKSDAY,            xi.day.LIGHTSDAY          }

-- Strong/Weak weather elements.
xi.combat.element.strongSingleWeather = { xi.weather.HOT_SPELL,      xi.weather.SNOW,          xi.weather.WIND,           xi.weather.DUST_STORM,      xi.weather.THUNDER,             xi.weather.RAIN,            xi.weather.AURORAS,         xi.weather.GLOOM          }
xi.combat.element.strongDoubleWeather = { xi.weather.HEAT_WAVE,      xi.weather.BLIZZARDS,     xi.weather.GALES,          xi.weather.SAND_STORM,      xi.weather.THUNDERSTORMS,       xi.weather.SQUALL,          xi.weather.STELLAR_GLARE,   xi.weather.DARKNESS       }
xi.combat.element.weakSingleWeather   = { xi.weather.RAIN,           xi.weather.HOT_SPELL,     xi.weather.SNOW,           xi.weather.WIND,            xi.weather.DUST_STORM,          xi.weather.THUNDER,         xi.weather.GLOOM,           xi.weather.AURORAS        }
xi.combat.element.weakDoubleWeather   = { xi.weather.SQUALL,         xi.weather.HEAT_WAVE,     xi.weather.BLIZZARDS,      xi.weather.GALES,           xi.weather.SAND_STORM,          xi.weather.THUNDERSTORMS,   xi.weather.DARKNESS,        xi.weather.STELLAR_GLARE  }

-- Elemental modifiers.
xi.combat.element.specificDmgTakenMod = { xi.mod.FIRE_SDT,           xi.mod.ICE_SDT,           xi.mod.WIND_SDT,           xi.mod.EARTH_SDT,           xi.mod.THUNDER_SDT,             xi.mod.WATER_SDT,           xi.mod.LIGHT_SDT,           xi.mod.DARK_SDT           }
xi.combat.element.resistRankMod       = { xi.mod.FIRE_RES_RANK,      xi.mod.ICE_RES_RANK,      xi.mod.WIND_RES_RANK,      xi.mod.EARTH_RES_RANK,      xi.mod.THUNDER_RES_RANK,        xi.mod.WATER_RES_RANK,      xi.mod.LIGHT_RES_RANK,      xi.mod.DARK_RES_RANK      }
xi.combat.element.nullMod             = { xi.mod.FIRE_NULL,          xi.mod.ICE_NULL,          xi.mod.WIND_NULL,          xi.mod.EARTH_NULL,          xi.mod.LTNG_NULL,               xi.mod.WATER_NULL,          xi.mod.LIGHT_NULL,          xi.mod.DARK_NULL          }
xi.combat.element.absorbMod           = { xi.mod.FIRE_ABSORB,        xi.mod.ICE_ABSORB,        xi.mod.WIND_ABSORB,        xi.mod.EARTH_ABSORB,        xi.mod.LTNG_ABSORB,             xi.mod.WATER_ABSORB,        xi.mod.LIGHT_ABSORB,        xi.mod.DARK_ABSORB        }
xi.combat.element.elementalMagicAcc   = { xi.mod.FIREACC,            xi.mod.ICEACC,            xi.mod.WINDACC,            xi.mod.EARTHACC,            xi.mod.THUNDERACC,              xi.mod.WATERACC,            xi.mod.LIGHTACC,            xi.mod.DARKACC            }
xi.combat.element.elementalMagicEva   = { xi.mod.FIRE_MEVA,          xi.mod.ICE_MEVA,          xi.mod.WIND_MEVA,          xi.mod.EARTH_MEVA,          xi.mod.THUNDER_MEVA,            xi.mod.WATER_MEVA,          xi.mod.LIGHT_MEVA,          xi.mod.DARK_MEVA          }
xi.combat.element.strongAffinityDmg   = { xi.mod.FIRE_AFFINITY_DMG,  xi.mod.ICE_AFFINITY_DMG,  xi.mod.WIND_AFFINITY_DMG,  xi.mod.EARTH_AFFINITY_DMG,  xi.mod.THUNDER_AFFINITY_DMG,    xi.mod.WATER_AFFINITY_DMG,  xi.mod.LIGHT_AFFINITY_DMG,  xi.mod.DARK_AFFINITY_DMG  }
xi.combat.element.strongAffinityAcc   = { xi.mod.FIRE_AFFINITY_ACC,  xi.mod.ICE_AFFINITY_ACC,  xi.mod.WIND_AFFINITY_ACC,  xi.mod.EARTH_AFFINITY_ACC,  xi.mod.THUNDER_AFFINITY_ACC,    xi.mod.WATER_AFFINITY_ACC,  xi.mod.LIGHT_AFFINITY_ACC,  xi.mod.DARK_AFFINITY_ACC  }
xi.combat.element.elementalObi        = { xi.mod.FORCE_FIRE_DWBONUS, xi.mod.FORCE_ICE_DWBONUS, xi.mod.FORCE_WIND_DWBONUS, xi.mod.FORCE_EARTH_DWBONUS, xi.mod.FORCE_LIGHTNING_DWBONUS, xi.mod.FORCE_WATER_DWBONUS, xi.mod.FORCE_LIGHT_DWBONUS, xi.mod.FORCE_DARK_DWBONUS }

-----------------------------------
-- 6 elements tables. (No Light nor Dark)
-----------------------------------
-- Elemental effects.
xi.combat.element.barSpell            = { xi.effect.BARFIRE,            xi.effect.BARBLIZZARD,       xi.effect.BARAERO,            xi.effect.BARSTONE,            xi.effect.BARTHUNDER,              xi.effect.BARWATER            }

-- Elemental merits.
xi.combat.element.blmMerit            = { xi.merit.FIRE_MAGIC_POTENCY,  xi.merit.ICE_MAGIC_POTENCY,  xi.merit.WIND_MAGIC_POTENCY,  xi.merit.EARTH_MAGIC_POTENCY,  xi.merit.LIGHTNING_MAGIC_POTENCY,  xi.merit.WATER_MAGIC_POTENCY  }
xi.combat.element.rdmMerit            = { xi.merit.FIRE_MAGIC_ACCURACY, xi.merit.ICE_MAGIC_ACCURACY, xi.merit.WIND_MAGIC_ACCURACY, xi.merit.EARTH_MAGIC_ACCURACY, xi.merit.LIGHTNING_MAGIC_ACCURACY, xi.merit.WATER_MAGIC_ACCURACY }
