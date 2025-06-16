-----------------------------------
-- Fishing_items
-----------------------------------
local fish_data = {
    ["Crayfish"] = {
        variations = {
            bastok_mines = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Bamboo Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            northern_san_doria = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_san_doria = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_ronfaure = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_ronfaure = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ghelsba_outpost = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_sarutabaruta = { 
                skill = 7, 
                location = "Pond", 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 7, 
                location = "Pond", 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            giddeus = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            pashhow_marshlands = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            rolanberry_fields = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            jugner_forest = {
                skill = 7,
                locations = {"Crystalwater Spring (J-9)", "Maiden's Spring (E-6)", "Lake Mechieume"},
                baits = {"Little Worm", "Fly Lure", "Lugworm"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            davoi = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_woods = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 7, 
                baits = {"Little Worm", "Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Moat Carp"] = {
        variations = {
            bastok_mines = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Bamboo Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_san_doria = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_ronfaure = { 
                skill = 11, 
                location = "Knight Well", 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_sarutabaruta = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            la_theine_plateau = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            rolanberry_fields = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            davoi = { 
                skill = 11, 
                location = "Ponds", 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_woods = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 11, 
                baits = {"Little Worm", "Insect Ball", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Tricolored Carp"] = {
        variations = {
            bastok_mines = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_san_doria = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_ronfaure = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ghelsba_outpost = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            giddeus = { 
                skill = 27, 
                location = "Pond & Spring", 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            gusgen_mines = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            rolanberry_fields = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            davoi = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 27, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Giant Catfish"] = {
        variations = {
            bastok_mines = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5, ["Yew Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_ronfaure = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_sarutabaruta = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 31, 
                location = "Pond", 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            giddeus = { 
                skill = 31, 
                location = "Pond", 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            pashhow_marshlands = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            rolanberry_fields = { 
                skill = 31, 
                location = "Lake", 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            jugner_forest = { 
                skill = 31, 
                location = "Lake Mechieume (Other)", 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            davoi = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 31, 
                baits = {"Frog Lure", "Worm Lure", "Sinking Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Red Terrapin"] = {
        variations = {
            west_ronfaure = { 
                skill = 53, 
                baits = {"Little Worm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            jugner_forest = { 
                skill = 53, 
                baits = {"Little Worm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            davoi = { 
                skill = 56, 
                baits = {"Little Worm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Dark Bass"] = {
        variations = {
            bastok_mines = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            west_sarutabaruta = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            giddeus = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            la_theine_plateau = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            rolanberry_fields = { 
                skill = 31, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            davoi = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            windurst_waters = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            south_gustaberg = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            north_gustaberg = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
            port_bastok = { 
                skill = 33, 
                baits = {"Worm Lure", "Sinking Minnow", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.3}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}, 
                time_bonus = {["Night"] = 1.2} 
            },
        }
    },

    ["Black Eel"] = {
        variations = {
            bastok_mines = { 
                skill = 47, 
                baits = {"Worm Lure", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6, ["Yew Fishing Rod"] = 0.4}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            gusgen_mines = { 
                skill = 47, 
                baits = {"Worm Lure", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6, ["Yew Fishing Rod"] = 0.4}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 47, 
                baits = {"Worm Lure", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6, ["Yew Fishing Rod"] = 0.4}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 47, 
                baits = {"Worm Lure", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6, ["Yew Fishing Rod"] = 0.4}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 47, 
                baits = {"Worm Lure", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6, ["Yew Fishing Rod"] = 0.4}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Gold Carp"] = {
        variations = {
            bastok_mines = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7, ["Yew Fishing Rod"] = 0.5}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_san_doria = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            east_ronfaure = { 
                skill = 21, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ghelsba_outpost = { 
                skill = 56, 
                location = "River", 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            gusgen_mines = { 
                skill = 56, 
                location = "Pools on first floor", 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            rolanberry_fields = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            davoi = { 
                skill = 53, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 56, 
                baits = {"Insect Ball", "Doughball"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.7}, 
                weather_bonus = {["Rain"] = 1.2}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Cheval Salmon"] = {
        variations = {
            east_ronfaure = { 
                skill = 21, 
                location = "Cheval River", 
                baits = {"Lugworm", "Little Worm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            jugner_forest = { 
                skill = 21, 
                baits = {"Lugworm", "Little Worm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 21, 
                baits = {"Lugworm", "Little Worm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Shining Trout"] = {
        variations = {
            east_ronfaure = { 
                skill = 37, 
                baits = {"Fly Lure", "Worm Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ghelsba_outpost = { 
                skill = 37, 
                baits = {"Fly Lure", "Worm Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            jugner_forest = { 
                skill = 37, 
                baits = {"Fly Lure", "Worm Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Pipira"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 29, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 29, 
                baits = {"Little Worm", "Insect Ball"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Ogre Eel"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 35, 
                location = "Sea", 
                baits = {"Lugworm", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 35, 
                location = "Sea", 
                baits = {"Lugworm", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 35, 
                baits = {"Lugworm", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Gold Lobster"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 46, 
                baits = {"Peeled Lobster", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 46, 
                baits = {"Peeled Lobster", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 46, 
                baits = {"Peeled Lobster", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Monke-Onke"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 51, 
                location = "Lake Tepokalipuka", 
                baits = {"Lugworm", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            giddeus = { 
                skill = 51, 
                location = "Spring", 
                baits = {"Lugworm", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Bluetail"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 55, 
                location = "Sea", 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            valkurm_dunes = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            buburimu_peninsula = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            sauromugue_champaign = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            qufim_island = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            beaucedine_glacier = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 55, 
                baits = {"Sardine", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Crescent Fish"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 69, 
                location = "Lake Tepokalipuka", 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Waxing Crescent"] = 1.5, ["Full Moon"] = 0} 
            },
        }
    },

    ["Bladefish"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 71, 
                location = "Sea", 
                baits = {"Minnow", "Sardine"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 71, 
                baits = {"Minnow", "Sardine"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 71, 
                baits = {"Minnow", "Sardine"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Bastore Bream"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 86, 
                baits = {"Shrimp Lure", "Minnow"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            west_sarutabaruta = { 
                skill = 86, 
                baits = {"Shrimp Lure", "Minnow"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 86, 
                baits = {"Shrimp Lure", "Minnow"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 86, 
                baits = {"Shrimp Lure", "Minnow"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 86, 
                baits = {"Shrimp Lure", "Minnow"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Quus"] = {
        variations = {
            west_sarutabaruta = { 
                skill = 19, 
                location = "Sea", 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            valkurm_dunes = { 
                skill = 19, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 19, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 19, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 19, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 19, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Gavial Fish"] = {
        variations = {
            gusgen_mines = { 
                skill = 81, 
                location = "Deeper Pools on Map 3", 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Cobalt Jellyfish"] = {
        variations = {
            valkurm_dunes = { 
                skill = 5, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 5, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            batallia_downs = { 
                skill = 5, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 5, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 5, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Greedie"] = {
        variations = {
            valkurm_dunes = { 
                skill = 14, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 14, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 14, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 14, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Zafmlug Bass"] = {
        variations = {
            valkurm_dunes = { 
                skill = 43, 
                baits = {"Worm Lure", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            selbina = { 
                skill = 43, 
                baits = {"Worm Lure", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 43, 
                baits = {"Worm Lure", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 43, 
                baits = {"Worm Lure", "Minnow"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Shall Shell"] = {
        variations = {
            valkurm_dunes = { 
                skill = 53, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            buburimu_peninsula = { 
                skill = 53, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 53, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 53, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Yellow Globe"] = {
        variations = {
            buburimu_peninsula = { 
                skill = 17, 
                location = "All", 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            mhaura = { 
                skill = 17, 
                location = "Sea", 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            batallia_downs = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            sauromugue_champaign = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            qufim_island = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            beaucedine_glacier = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 17, 
                baits = {"Peeled Shrimp", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Bastore Sardine"] = {
        variations = {
            selbina = { 
                skill = 9, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            mhaura = { 
                skill = 9, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 9, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 9, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 9, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Fat Greedie"] = {
        variations = {
            selbina = { 
                skill = 24, 
                baits = {"Peeled Shrimp", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 24, 
                baits = {"Peeled Shrimp", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 24, 
                baits = {"Peeled Shrimp", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod", "Composite Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

     ["Copper Frog"] = {
        variations = {
            pashhow_marshlands = { 
                skill = 16, 
                baits = {"Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            windurst_waters = { 
                skill = 16, 
                baits = {"Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            south_gustaberg = { 
                skill = 16, 
                baits = {"Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            north_gustaberg = { 
                skill = 16, 
                baits = {"Fly Lure", "Lugworm"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Pamtam Kelp"] = {
        variations = {
            buburimu_peninsula = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            mhaura = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            qufim_island = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 10, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Silver Shark"] = {
        variations = {
            sauromugue_champaign = { 
                skill = 76, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            ferry_mhaura_selbina = { 
                skill = 76, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 76, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Rusty Greatsword"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            west_sarutabaruta = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            bibiki_bay = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            port_bastok = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
        }
    },

    ["Copper Ring"] = {
        variations = {
            east_sarutabaruta = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            west_sarutabaruta = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            valkurm_dunes = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            selbina = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            bibiki_bay = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            port_bastok = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
        }
    },

    ["Bhefhel Marlin"] = {
        variations = {
            ferry_mhaura_selbina = { 
                skill = 84, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 84, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Noble Lady"] = {
        variations = {
            ferry_mhaura_selbina = { 
                skill = 90, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 90, 
                baits = {"Minnow", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Tiger Cod"] = {
        variations = {
            qufim_island = { 
                skill = 29, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            bibiki_bay = { 
                skill = 29, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 29, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Cone Calamary"] = {
        variations = {
            bibiki_bay = { 
                skill = 41, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
            port_bastok = { 
                skill = 41, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.6}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Crystal Crab"] = {
        variations = {
            beaucedine_glacier = { 
                skill = 65, 
                baits = {"Peeled Shrimp", "Shrimp Lure"}, 
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.8}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Icefish"] = {
        variations = {
            beaucedine_glacier = { 
                skill = 28, 
                baits = {"Lugworm", "Peeled Shrimp"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Sandfish"] = {
        variations = {
            batallia_downs = { 
                skill = 34, 
                baits = {"Lugworm", "Little Worm"}, 
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"}, 
                break_chance = {["Willow Fishing Rod"] = 0.5}, 
                weather_bonus = {}, 
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9} 
            },
        }
    },

    ["Rusty Subligar"] = {
        variations = {
            port_bastok = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
            bibiki_bay = { 
                skill = 0, 
                baits = {"Lugworm", "Sabiki Rig"}, 
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"}, 
                weather_bonus = {}, 
                moon_bonus = {} 
            },
        }
    },

    ["Jungle Catfish"] = {
        variations = {
            yhoator_jungle = {
                skill = 45,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            yuhtunga_jungle = {
                skill = 45,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Yayinbaligi"] = {
        variations = {
            kazham = {
                skill = 63,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            yhoator_jungle = {
                skill = 63,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Zebra Eel"] = {
        variations = {
            sea_serpent_grotto = {
                skill = 47,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Veydal Wrasse"] = {
        variations = {
            norg = {
                skill = 80,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            sea_serpent_grotto = {
                skill = 80,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Mithran Whisker"] = {
        variations = {
            kazham = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            norg = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Saber Sardine"] = {
        variations = {
            rabao = {
                skill = 12,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Desert Catfish"] = {
        variations = {
            rabao = {
                skill = 38,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Grimmonite"] = {
        variations = {
            kuftal_tunnel = {
                skill = 85,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Ryugu Titan"] = {
        variations = {
            cape_teriggan = {
                skill = 90,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Sea Dragon"] = {
        variations = {
            valley_of_sorrows = {
                skill = 95,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Black Sole"] = {
        variations = {
            gustav_tunnel = {
                skill = 70,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Heavenly Fish"] = {
        variations = {
            ru_aun_gardens = {
                skill = 100,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Divine Carp"] = {
        variations = {
            the_shrine_of_ru_avitau = {
                skill = 100,
                baits = {"Insect Ball", "Doughball"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Aether Eel"] = {
        variations = {
            ro_maeve = {
                skill = 100,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    }

     ["Hakuryu"] = {
        variations = {
            al_zahbi = {
                skill = 73,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            ferry_al_zahbi_nashmau = {
                skill = 73,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Mola Mola"] = {
        variations = {
            nashmau = {
                skill = 88,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            ferry_al_zahbi_nashmau = {
                skill = 88,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Lungfish"] = {
        variations = {
            carpenters_landing = {
                skill = 42,
                baits = {"Worm Lure", "Frog Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Lakerda"] = {
        variations = {
            bibiki_bay_purgonorgo_isle = {
                skill = 79,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Kalkanbaligi"] = {
        variations = {
            al_zahbi_open_sea_route = {
                skill = 85,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            nashmau_open_sea_route = {
                skill = 85,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Pond Carp"] = {
        variations = {
            phomiuna_aqueducts = {
                skill = 15,
                baits = {"Little Worm", "Insect Ball"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Arrowwood Log"] = {
        variations = {
            carpenters_landing = {
                skill = 0,
                baits = {"Little Worm", "Lugworm"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Tavnazian Goby"] = {
        variations = {
            tavnazian_safehold = {
                skill = 20,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            misareaux_coast = {
                skill = 20,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Caedarva Toad"] = {
        variations = {
            ilverm_marsh = {
                skill = 50,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Lik"] = {
        variations = {
            lufaise_meadows = {
                skill = 92,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Aurora Bass"] = {
        variations = {
            riverne_site_a01 = {
                skill = 60,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            riverne_site_b01 = {
                skill = 60,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Empyrean Shrimp"] = {
        variations = {
            monarch_linn = {
                skill = 98,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Pelazoea"] = {
        variations = {
            sealion_den = {
                skill = 75,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Matsya"] = {
        variations = {
            al_taieu = {
                skill = 100,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Phantom Serpent"] = {
        variations = {
            grand_palace_of_huzaar = {
                skill = 100,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Elysian Eel"] = {
        variations = {
            garden_of_rulude = {
                skill = 100,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Mercenary's Mantle"] = {
        variations = {
            aht_urhgan_whitegate = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Sardine"] = {
        variations = {
            aht_urhgan_whitegate = {
                skill = 10,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            silver_sea_route_to_al_zahbi = {
                skill = 10,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            silver_sea_route_to_nashmau = {
                skill = 10,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Aht Urhgan Brass"] = {
        variations = {
            al_zahbi = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            nashmau = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Qiqirn Chocobo Egg"] = {
        variations = {
            halvung = {
                skill = 0,
                baits = {"Little Worm", "Lugworm"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Mamool Ja Catfish"] = {
        variations = {
            mamook = {
                skill = 55,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Yorchete"] = {
        variations = {
            wajaom_woodlands = {
                skill = 65,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Poroggo Perch"] = {
        variations = {
            bhaflau_thickets = {
                skill = 70,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Arrapago Mullet"] = {
        variations = {
            arrapago_reef = {
                skill = 82,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Lava Eel"] = {
        variations = {
            mount_zhayolm = {
                skill = 90,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Shen"] = {
        variations = {
            caedarva_mire = {
                skill = 95,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Astral Flounder"] = {
        variations = {
            alzadaal_undersea_ruins = {
                skill = 100,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Dil"] = {
        variations = {
            talacca_cove = {
                skill = 85,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Kawahori"] = {
        variations = {
            hazhalm_testing_grounds = {
                skill = 88,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Orontes"] = {
        variations = {
            lebros_cavern = {
                skill = 92,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Serrated Dagger"] = {
        variations = {
            ilrusi_atoll = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Apkallu Egg"] = {
        variations = {
            periqiq_cavern = {
                skill = 0,
                baits = {"Little Worm", "Lugworm"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Black Prawn"] = {
        variations = {
            ashu_talif = {
                skill = 75,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Gilded Carp"] = {
        variations = {
            north_san_doria_d = {
                skill = 25,
                baits = {"Little Worm", "Insect Ball"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            southern_san_doria_d = {
                skill = 25,
                baits = {"Little Worm", "Insect Ball"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Bronze Carp"] = {
        variations = {
            bastok_markets_d = {
                skill = 20,
                baits = {"Little Worm", "Insect Ball"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            north_gustaberg_d = {
                skill = 20,
                baits = {"Little Worm", "Insect Ball"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Windurstian Perch"] = {
        variations = {
            windurst_waters_d = {
                skill = 30,
                baits = {"Worm Lure", "Little Worm"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            west_sarutabaruta_d = {
                skill = 30,
                baits = {"Worm Lure", "Little Worm"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["War Carp"] = {
        variations = {
            batallia_downs_d = {
                skill = 35,
                baits = {"Worm Lure", "Insect Ball"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            rolanberry_fields_d = {
                skill = 35,
                baits = {"Worm Lure", "Insect Ball"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.5},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Crystal Eel"] = {
        variations = {
            east_ronfaure_d = {
                skill = 40,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            jugner_forest_d = {
                skill = 40,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Marsh Goby"] = {
        variations = {
            pashhow_marshlands_d = {
                skill = 15,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Saberfish"] = {
        variations = {
            sauromugue_champaign_d = {
                skill = 50,
                baits = {"Minnow", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Grauberg Greens"] = {
        variations = {
            grauberg_d = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Vunkerl Herring"] = {
        variations = {
            vunkerl_inlet_d = {
                skill = 60,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Karugo Catfish"] = {
        variations = {
            fort_karugo_narugo_d = {
                skill = 45,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Composite Fishing Rod", "Mithran Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Riverne Trout"] = {
        variations = {
            cape_riverne = {
                skill = 70,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Everbloom Mackerel"] = {
        variations = {
            everbloom_hollow = {
                skill = 80,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Ghoyu Squid"] = {
        variations = {
            ghoyu_s_reverie = {
                skill = 85,
                baits = {"Shrimp Lure", "Peeled Shrimp"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Silver Ore"] = {
        variations = {
            ruhoytz_silvermines = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Vaule Eel"] = {
        variations = {
            la_vaule_d = {
                skill = 90,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Abyssal Flounder"] = {
        variations = {
            abyssea_altepa = {
                skill = 95,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Attohwa Chub"] = {
        variations = {
            abyssea_attohwa = {
                skill = 90,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Grauberg Perch"] = {
        variations = {
            abyssea_grauberg = {
                skill = 85,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Konschtat Carp"] = {
        variations = {
            abyssea_konschtat = {
                skill = 80,
                baits = {"Insect Ball", "Worm Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["La Theine Goby"] = {
        variations = {
            abyssea_la_theine = {
                skill = 75,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Misareaux Mullet"] = {
        variations = {
            abyssea_misareaux = {
                skill = 88,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Tahrongi Trout"] = {
        variations = {
            abyssea_tahrongi = {
                skill = 82,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Uleguerand Eel"] = {
        variations = {
            abyssea_uleguerand = {
                skill = 92,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Vunkerl Bass"] = {
        variations = {
            abyssea_vunkerl = {
                skill = 90,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Cruor Crab"] = {
        variations = {
            abyssea_misareaux = {
                skill = 85,
                baits = {"Peeled Shrimp", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            abyssea_vunkerl = {
                skill = 85,
                baits = {"Peeled Shrimp", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Abyssite Shard"] = {
        variations = {
            abyssea_konschtat = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            abyssea_la_theine = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            abyssea_tahrongi = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Ceizak Catfish"] = {
        variations = {
            ceizak_battlegrounds = {
                skill = 75,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Yahse Mullet"] = {
        variations = {
            yahse_hunting_grounds = {
                skill = 80,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Hennetiel Perch"] = {
        variations = {
            foret_de_hennetiel = {
                skill = 85,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Morimar Bass"] = {
        variations = {
            morimar_basalt_fields = {
                skill = 88,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Marjami Trout"] = {
        variations = {
            marjami_ravine = {
                skill = 90,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Kamihr Eel"] = {
        variations = {
            kamihr_drifts = {
                skill = 92,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Sih Snapper"] = {
        variations = {
            sih_gates = {
                skill = 87,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Moh Mackerel"] = {
        variations = {
            moh_gates = {
                skill = 89,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Cirdas Crab"] = {
        variations = {
            cirdas_caverns = {
                skill = 90,
                baits = {"Peeled Shrimp", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Dho Goby"] = {
        variations = {
            dho_gates = {
                skill = 85,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Woh Shrimp"] = {
        variations = {
            woh_gates = {
                skill = 88,
                baits = {"Peeled Shrimp", "Shrimp Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Kaznar Catfish"] = {
        variations = {
            outer_ra_kaznar = {
                skill = 95,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            ra_kaznar_inner_court = {
                skill = 95,
                baits = {"Frog Lure", "Worm Lure"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Velkk Scale"] = {
        variations = {
            ceizak_battlegrounds = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            yahse_hunting_grounds = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Coalition Rune"] = {
        variations = {
            foret_de_hennetiel = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            morimar_basalt_fields = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Eschan Carp"] = {
        variations = {
            escha_zitah = {
                skill = 90,
                baits = {"Insect Ball", "Worm Lure"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.9, ["Yew Fishing Rod"] = 0.7},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Ruaun Eel"] = {
        variations = {
            escha_ruaun = {
                skill = 95,
                baits = {"Shrimp Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Reisenjima Trout"] = {
        variations = {
            reisenjima = {
                skill = 100,
                baits = {"Worm Lure", "Minnow"},
                rods = {"Halcyon Fishing Rod", "Lu Shang's Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.95, ["Yew Fishing Rod"] = 0.8},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Cloud Goby"] = {
        variations = {
            escha_zitah = {
                skill = 85,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
            escha_ruaun = {
                skill = 85,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Mithran Fishing Rod", "Halcyon Fishing Rod"},
                break_chance = {["Willow Fishing Rod"] = 0.8, ["Yew Fishing Rod"] = 0.6},
                weather_bonus = {},
                moon_bonus = {["Full Moon"] = 1.1, ["New Moon"] = 0.9}
            },
        }
    },

    ["Iroha's Scale"] = {
        variations = {
            reisenjima = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },

    ["Cait Sith Whisker"] = {
        variations = {
            escha_zitah = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
            escha_ruaun = {
                skill = 0,
                baits = {"Lugworm", "Sabiki Rig"},
                rods = {"Willow Fishing Rod", "Yew Fishing Rod"},
                weather_bonus = {},
                moon_bonus = {}
            },
        }
    },
}

return fish_data