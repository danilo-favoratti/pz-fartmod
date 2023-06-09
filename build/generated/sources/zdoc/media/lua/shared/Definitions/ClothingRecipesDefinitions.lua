---@class ClothingRecipesDefinitions
ClothingRecipesDefinitions = {};

ClothingRecipesDefinitions["Sheet"] = {materials="Base.RippedSheets:4" }
--ClothingRecipesDefinitions["Belt2"] = {materials="Base.LeatherStrips:1"}


ClothingRecipesDefinitions["FabricType"] = {}
ClothingRecipesDefinitions["FabricType"]["Cotton"] = {};
ClothingRecipesDefinitions["FabricType"]["Cotton"].material = "Base.RippedSheets";

ClothingRecipesDefinitions["FabricType"]["Denim"] = {};
ClothingRecipesDefinitions["FabricType"]["Denim"].material = "Base.DenimStrips";
-- ClothingRecipesDefinitions["FabricType"]["Denim"].tools = "Base.Scissors"; -- commented out as they are unused; recipe code handles this
ClothingRecipesDefinitions["FabricType"]["Denim"].noSheetRope = true;

ClothingRecipesDefinitions["FabricType"]["Leather"] = {}
ClothingRecipesDefinitions["FabricType"]["Leather"].material = "Base.LeatherStrips";
-- ClothingRecipesDefinitions["FabricType"]["Leather"].tools = "Base.Scissors"; -- commented out as they are unused; recipe code handles this
ClothingRecipesDefinitions["FabricType"]["Leather"].noSheetRope = true;
