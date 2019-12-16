USE TPCentralDB;

IF NOT EXISTS(SELECT * FROM MessageText
	WHERE szTextID=N'mobile-payment-no-response-received' AND szContextID=N'TPDotnet.POS.TabletPOS' AND szLanguageCode=N'en-GB' AND lRowIndex=0)
BEGIN
	INSERT INTO MessageText (szTextID,szContextID,szLanguageCode,lRowIndex,szTranslation,szCustomerName,szAdditionalInformation) VALUES (N'mobile-payment-no-response-received',N'TPDotnet.POS.TabletPOS',N'en-GB',0,N'No response received',N'Sephora.Adyen',N'Adyen Message')
END
ELSE
BEGIN
	UPDATE MessageText SET szTranslation=N'No response received',szCustomerName=N'Sephora.Adyen',szAdditionalInformation=N'Adyen Message' WHERE szTextID=N'mobile-payment-no-response-received' AND szContextID=N'TPDotnet.POS.TabletPOS' AND szLanguageCode=N'en-GB' AND lRowIndex=0
END
GO






