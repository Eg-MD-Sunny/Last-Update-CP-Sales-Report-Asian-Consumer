-----|| 1st Part
-----|| Name: Updated Asian Consumer CP Sales Report

SELECT 
	cast(dbo.ToBdt(Shipment.CreatedOn)as date)[CreatedOnDate],
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date)[ReconciledOnDate],
	ProductVariant.Id ProductVariantId,
	ProductVariant.Name ProductVariantName,
	COUNT (ProductVariant.Id) Quantity,
	ThingRequest.SalePrice SalePrice,
	COUNT (ProductVariant.Id)*ThingRequest.SalePrice OrderValue
	

FROM
	ProductVariant
	Join ThingRequest on ThingRequest.ProductVariantId = ProductVariant.Id
	Join Thing on ThingRequest.AssignedThingId = Thing.Id
	Join Shipment on ThingRequest.ShipmentId = Shipment.Id

WHERE
	ProductVariant.Id in (27204,27205,27189)

	and Shipment.ReconciledOn >= '2022-03-01 00:00 +06:00'
	and Shipment.CreatedOn  < '2022-04-01 00:00 +06:00'				
	
	and ThingRequest.Mrp <> ThingRequest.ListPrice
	and Shipment.ShipmentStatus in (8)
	and ThingRequest.IsReturned = 0
	and ThingRequest.IsCancelled = 0
	and ThingRequest.HasFailedBeforeDispatch =0
	and ThingRequest.IsMissingAfterDispatch = 0
	and Thing.CostPrice is not NULL
	and Shipment.ReconciledOn is not NULL
	
GROUP BY
	cast(dbo.ToBdt(Shipment.CreatedOn)as date),
	cast(dbo.ToBdt(Shipment.ReconciledOn)as date),
	ProductVariant.Id ,
	ProductVariant.Name ,
	ThingRequest.SalePrice 

Order by 
	ProductVariantName