<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<!--     Custom function to find and replace string     -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)" />
				<xsl:value-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="/">
		<!--     HERO: YOUR ORDER CONFIRMATION     -->
		<tr>
			<td align="center" valign="top">
				<table align="center" class="em_main_table" bgcolor="#ffffff" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed; width: 640px;">
					<tbody>
						<tr>
							<td height="40" class="em_height" style="line-height: 0px; font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
							</td>
						</tr>
						<tr>
							<td valign="top" align="center" width="640" class="em_full_img1">
								<img src="https://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/e4cbe52d-42ba-41ea-99fc-7b09758bbbb2.png" alt="ProgressBar" width="640" class="em_full_img" style="display: block; max-width: 640px;" border="0" />
							</td>
						</tr>
						<tr>
							<td height="40" class="em_height" style="line-height: 0px; font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
							</td>
						</tr>
						<tr>
							<td class="em_black em_aside" valign="top" align="center" style="font-family: Arial, sans-serif; font-size: 24px; color: #000000; padding-left: 63px; padding-right: 63px; line-height: 28px; font-weight: 300; letter-spacing: 2px;">Your Order Is Complete And Ready For Collection</td>
						</tr>
						<tr>
							<td height="30" style="line-height: 0px; font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
							</td>
						</tr>
						<tr>
							<td class="em_black em_aside" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; padding-left: 63px; padding-right: 63px; line-height: 18px;">
								Hi
								<xsl:value-of select="//message/subscribers/subscriber/firstname" />
								,
							</td>
						</tr>

						<tr>
							<td class="em_black em_aside" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; padding-left: 63px; padding-right: 63px; line-height: 18px;">
								Your Click &amp; Collect order is now ready for pick-up from
								<a href="https://www.myer.com.au/store-locator" target="_blank" style="text-decoration: none; color: #000000; font-weight:bold;text-decoration:underline;">
									<xsl:value-of select="//message/additional-content/order/order-snapshot/storeDetails/store-name" />
								</a>
								.
								<br />
								Head to the Hub on level 1 next to Bedding and Manchester and present
								<strong>this barcode</strong>
								and your
								<strong>photo ID</strong>
								for collection.
								<br />
								<br />

							</td>
						</tr>
						<tr>
							<td height="20" style="line-height: 0px;font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
							</td>
						</tr>
						%%[ VAR @OrderNum, @Barcode,/*Generate Barcode from the order number*/ 
SET @OrderNum = '
						<xsl:value-of select="//message/additional-content/order/order-number" />
						' 
SET @Barcode = BarCodeURL(@OrderNum,'Code93', 400, 80, 0)]%%
						<tr>
							<td align="center" valign="top">
								<!--     BARCODE_IMAGE     -->
								<img src="%%=v(@Barcode)=%%" alt="%%=v(@OrderNum)=%%" style="display: block; max-width: 400px; height: 80px;" border="0" width="400" class="em_img" />
							</td>
						</tr>
						<tr>
							<td height="20" style="line-height: 0px; font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
							</td>
						</tr>

						<!--     PICK-UP_INFO      -->
						<xsl:apply-templates select="message/additional-content/order/order-change" />
						<!--     //PICK-UP_INFO     -->
					</tbody>
				</table>
			</td>
		</tr>
		<!--     //HERO     -->
		<!--     DIVIDER: ITEMS READY FOR PICK UP     -->
		<tr>
			<td align="center" valign="top">
				<table align="center" class="em_main_table" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed; width:640px;" bgcolor="#ffffff">
					<tbody>
						<tr>
							<td height="47" class="em_height">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
							</td>
						</tr>
						<tr>
							<td valign="top" align="center" style="padding:0px 63px;" class="em_aside">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
									<tr>

										<td class="em_black" width="190" valign="top" align="center" style="font-family: Arial, sans-serif;font-size:14px;color:#000000;line-height:16px;">ITEMS READY TO PICK UP</td>
										<td width="37" class="em_side">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
										</td>
										<td valign="top" align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
												<tr>
													<td height="7" style="line-height: 0px;font-size: 0px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
												<tr>
													<td height="1" bgcolor="#ffffff" style="line-height:1px;font-size:1px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
												<tr>
													<td height="8" style="line-height: 0px;font-size: 0px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="47" class="em_height">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
		<!--     //DIVIDER     -->
		<!--




Counts the number of item in items and also changes the table layout
-->
		<xsl:choose>
			<xsl:when test="count(//message/additional-content/order/order-change/items/item) > 10">
%%[ VAR @WidthTD, @Breaks, @WidthTB SET @WidthTD = 37 SET @WidthTB = 300 SET @WidthTB2 = 185 SET @AlignText = 'center' SET @Breaks = ', ' ]%%
</xsl:when>
			<xsl:otherwise>
				%%[ SET @WidthTD = 143 SET @WidthTB = 274 SET @WidthTB2 = 144 SET @AlignText = 'right' SET @Breaks = '
				<br />
				' ]%%
			</xsl:otherwise>
		</xsl:choose>
		<!--     //DESKTOP_DIVIDER_SUBHEAD_2     -->
		<tr>
			<td align="center" valign="top">
				<table align="center" class="em_main_table" bgcolor="#ffffff" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed; width:640px;">
					<tr>
						<td valign="top" align="center" class="em_aside" style="padding-left: 63px;padding-right: 63px;">
							<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td valign="top" align="%%=v(@AlignText)=%%" width="346" style="font-family:Arial, sans-serif; font-size:14px;color: #1d1d1d;font-weight: bold;">Description</td>
									<td valign="top" class="em_hide" align="%%=v(@AlignText)=%%" width="170" style="font-family:Arial, sans-serif; font-size:14px;color: #1d1d1d;font-weight: bold;">Price</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td height="15" class="em_height">
				<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
			</td>
		</tr>
		<!--     PRODUCT_ITEM: LARGE     -->
		<xsl:for-each select="message/additional-content/order/order-change/items/item">
			<xsl:variable name="VImageURL">
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="image" />
					<xsl:with-param name="replace" select="'myer-media.online.aws.myer.internal'" />
					<xsl:with-param name="by" select="'myer.com.au'" />
				</xsl:call-template>
			</xsl:variable>
			<xsl:variable name="Vdescription">
				<xsl:value-of select="description" />
			</xsl:variable>
			<xsl:if test="fulfillment-method!=''">
				%%[ SET @DelType = "
				<xsl:value-of select="fulfillment-method" />
				" 
SET @DelMethd = "
				<xsl:value-of select="delivery-method" />
				" IF @DelType == 'SHP' THEN (IF (@DelMethd=='SAME_DAY_SHIP') THEN SET @VDelMethd='Same Day Delivery' ELSEIF (@DelMethd=='NEXT_DAY_SHIP') THEN SET @VDelMethd='Next Day Delivery' ELSEIF (@DelMethd=='STANDARD') THEN SET @VDelMethd='Standard' ENDIF) ELSE SET @VDelMethd = 'Click &amp; Collect' ENDIF]%%
			</xsl:if>
			<xsl:if test="image!=''">
				%%[ set @imageurl = ReplaceList("
				<xsl:value-of select="image" />
				","myer.com.au","myer-media.online.aws.myer.internal","wcsadminprod.myer.com.au") ]%%
			</xsl:if>
			<!--     DESKTOP_PRODUCT_LARGE_4     -->
			<tr>
				<td align="center" valign="top">
					<table align="center" class="em_main_table" bgcolor="#ffffff" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed; width:640px;">
						<tr>
							<td height="30" class="em_height" style="line-height:0px; font-size:0px; ">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" width="1" height="1" alt="" border="0" style="display:block;" />
							</td>
						</tr>
						<tr>
							<td valign="top" align="center" class="em_aside" style="padding-left: 63px;padding-right: 63px;">
								<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top" align="center" width="%%=v(@WidthTD)=%%" class="em_full_img1">
											<!--     ITEM_IMAGE     -->
											<xsl:choose>
												<xsl:when test="image!=''">
													<img src="%%=v(@imageurl)=%%" alt="{$Vdescription}" width="%%=v(@WidthTD)=%%" class="em_full_img" style="display: block; max-width: %%=v(@WidthTD)=%%px;" border="0" />
												</xsl:when>
												<xsl:otherwise>
													<img src="http://de3u9r6k5xww7.cloudfront.net/wp-content/uploads/2012/07/Myer_logo.jpg" alt="%%item_name%%" width="%%=v(@WidthTD)=%%" class="em_full_img" style="display: block; max-width:%%=v(@WidthTD)=%%px" border="0" />
												</xsl:otherwise>
											</xsl:choose>
											<!--     //ITEM_IMAGE     -->
										</td>
										<td width="16" style="width: 16px;" class="em_side">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" width="1" height="1" alt="" border="0" style="display:block;" />
										</td>
										<td valign="top" align="center">
											<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td valign="top" align="center">
														<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
															<tr>
																<td valign="top" align="center">
																	<table width="%%=v(@WidthTB)=%%" style="width: %%=v(@WidthTB)=%%px;" class="em_wrapper" align="left" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td align="center" valign="top">
																				<table width="%%=v(@WidthTB)=%%" style="width: %%=v(@WidthTB)=%%px;" class="em_wrapper" align="center" border="0" cellspacing="0" cellpadding="0">
																					<tr>
																						<td align="left" valign="top">
																							<table width="%%=v(@WidthTB2)=%%" style="width: %%=v(@WidthTB2)=%%px;" class="em_wrapper" align="left" border="0" cellspacing="0" cellpadding="0">
																								<tr>
																									<td class="em_white" valign="top" align="left" style="font-family:Arial, sans-serif; font-size:14px; line-height:16px; color:#ffffff;word-break: break-all;">
																										<!--     ITEM_INFO     -->
																										<strong>
																											<xsl:value-of select="description" />
																										</strong>
																										<br />
																										<xsl:if test="clearance-item!=''">
																											<strong>
																												<xsl:value-of select="clearance-item" />
																											</strong>
																										</xsl:if>
																										<span style="font-size: 10px;">
																											<xsl:if test="OrderQty!=''">
																												<strong>
																													QTY
																													<xsl:value-of select="OrderQty" />
																												</strong>
																												%%=v(@Breaks)=%%
																											</xsl:if>
																											<xsl:if test="colour!=''">
																												Color:
																												<xsl:value-of select="colour" />
																												%%=v(@Breaks)=%%
																											</xsl:if>
																											<xsl:if test="size1!=''">
																												Size:
																												<xsl:value-of select="size1" />
																												<xsl:if test="size2!=''">
																													<xsl:value-of select="size2" />
																												</xsl:if>
																												%%=v(@Breaks)=%%
																											</xsl:if>
																											<xsl:if test="item-id!=''">
																												SKU:
																												<xsl:value-of select="item-id" />
																												%%=v(@Breaks)=%%
																											</xsl:if>
																										</span>
																										<br />

																									</td>
																									<td width="10" style="width:10px;"></td>
																								</tr>
																								<xsl:if test="gift-message!=''">
																									<!--     GIFT_MESSAGE     -->
																									<tr>
																										<td class="em_white" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 8px; line-height: 18px; color: #ffffff;padding-left:0px;">GIFT MESSAGING SELECTED </td>
																									</tr>
																								</xsl:if>
																							</table>

																							<table width="110" style="width: 100px;" class="em_wrapper" align="right" border="0" cellspacing="0" cellpadding="0">
																								<tr>
																									<td align="left" valign="top">
																										<table width="110" style="width: 110px;" class="em_wrapper" align="left" border="0" cellspacing="0" cellpadding="0">
																											<tr>
																												<td class="em_white em_left" valign="top" align="right" style="font-family:Arial, sans-serif; font-size:14px; line-height:18px; color:#686868; ">
																													<strong>
																														$
																														<xsl:value-of select="unit-price" />
																													</strong>
																													<!--     Loop the discount amount     -->
																													<xsl:if test="discounts/discount/amount!=''">
																														<xsl:for-each select="discounts/discount">
																															<xsl:choose>
																																<xsl:when test="contains(Type, 'MyerStaffDiscount')">
																																	<br />
																																	<span style="color: #d0021b;font-size:11px;">
																																		Staff -$
																																		<xsl:value-of select="amount" />
																																	</span>
																																</xsl:when>
																																<xsl:otherwise>
																																	<br />
																																	<span style="color: #d0021b;font-size:11px;">
																																		Discount -$
																																		<xsl:value-of select="amount" />
																																	</span>
																																</xsl:otherwise>
																															</xsl:choose>
																														</xsl:for-each>
																													</xsl:if>
																													<!--     Loop the charge amount     -->
																													<xsl:if test="Charges/Charge/amount!=''">
																														<xsl:for-each select="Charges/Charge">
																															<xsl:choose>
																																<xsl:when test="contains(Type, 'GIFT')">
																																	<br />
																																	<span style="color: #8f8d8e;font-size: 11px;">
																																		Gift Wrap $
																																		<xsl:value-of select="amount" />
																																	</span>
																																</xsl:when>
																																<xsl:otherwise>
																																	<br />
																																	<span style="color: #8f8d8e;font-size: 11px;">
																																		<xsl:value-of select="Type" />
																																		$
																																		<xsl:value-of select="amount" />
																																	</span>
																																</xsl:otherwise>
																															</xsl:choose>
																														</xsl:for-each>
																													</xsl:if>
																												</td>
																											</tr>
																										</table>
																									</td>
																								</tr>
																							</table>
																						</td>
																					</tr>
																				</table>
																			</td>
																		</tr>
																	</table>
																</td>
																<td align="right" valign="top">
																	<table width="80" class="em_wrapper" style="width: 80px;" align="right" border="0" cellspacing="0" cellpadding="0">
																		<tr>
																			<td class="em_grey2 em_left" valign="top" align="right" style="font-family:Arial, sans-serif; font-size:14px; line-height:18px; color:#686868; ">
																				<strong>
																					$
																					<xsl:value-of select="total-price" />
																				</strong>
																			</td>
																		</tr>
																	</table>
																</td>
															</tr>
														</table>
													</td>
												</tr>
												<xsl:if test="count(item) > 10">
													<tr>
														<td height="6" style="line-height:0px; font-size:0px;">
															<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" width="1" height="1" alt="" border="0" style="display:block;" />
														</td>
													</tr>
												</xsl:if>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td height="30" class="em_height" style="line-height:0px; font-size:0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" width="1" height="1" alt="" border="0" style="display:block;" />
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<!--     //DESKTOP_PRODUCT_LARGE_4     -->
			<xsl:if test="position() != last()">
				<!--     ITEM_DIVIDER     -->
				<tr>
					<td align="center" valign="top">
						<table align="center" class="em_main_table" bgcolor="#ffffff" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed; width: 640px;">
							<tbody>
								<tr>
									<td valign="top" align="center" class="em_aside" style="padding-left: 63px; padding-right: 63px;">
										<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
											<tbody>
												<tr>
													<td height="14" style="line-height: 0px; font-size: 0px; border-bottom: 1px dashed #ffffff;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
													</td>
												</tr>
												<tr>
													<td height="14" style="line-height: 0px; font-size: 0px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<!--     ITEM_DIVIDER     -->
			</xsl:if>
		</xsl:for-each>
		<!--     //PRODUCT_ITEM: LARGE     -->
		<!--     PRODUCT_TOTAL     -->
		<xsl:apply-templates select="message/additional-content/order/order-change/Order-Change-totals" />
		<!--     //PRODUCT_TOTAL     -->
		<!--     ORDERSUMMARY_MYERONE     -->
		<xsl:apply-templates select="message/additional-content/order" />
		<!--     //ORDERSUMMARY_MYERONE     -->
	</xsl:template>
	<!--     PICK-UP_INFO      -->
	<xsl:template match="message/additional-content/order/order-change">
		%%[ VAR @StoreDE, @ID, @PUInstructions, @ClickCollectInd, @Name, @OrderNum, @Barcode, @PickUpdate, @FormatPickUpdate, @PickUpInstruction, @row1, @StoreDErows, @RowCountDE,@StoreTradingHours,@tradingRows,@rowCount1,@dayShortName,@ccDayOfWeek,@rowsDayString,@ccDayString,@rowCountA,@StoreHoursFormatted /*Generate Barcode from the order number*/ 
SET @OrderNum = '
		<xsl:value-of select="//message/additional-content/order/order-number" />
		' 
SET @Barcode = BarCodeURL(@OrderNum,'Code93', 400, 80, 0)
		<xsl:if test="tracking/Estimated-shipment-date!=''">
			/*Format the pick up date*/ SET @PickUpdate = '
			<xsl:value-of select="tracking/Estimated-shipment-date" />
			' 
SET @FormatPickUpdate = Format(SystemDateToLocalDate(@PickUpdate), "dddd dd MMM yyyy") set @dayShortName = FormatDate(SystemDateToLocalDate(@PickUpdate),"dddd") set @donotDisplayHours = 0 if empty(@dayShortName) then set @donotDisplayHours=1 endif
		</xsl:if>
		<xsl:if test="storeDetails/store-id!=''">
			/*Look up reference to display instruction details per store*/ SET @ID = '
			<xsl:value-of select="storeDetails/store-id" />
			' 
SET @openingHours = 'DEFAULT FOR TEST' SET @StoreHoursFormatted = '' SET @StoreDErows = LookupOrderedRows('Store_Instructions_Test', 1, 'Identifier ASC', 'Identifier', @ID, 'ClickCollectInd','TRUE') SET @RowCountDE = RowCount(@StoreDErows) IF @RowCountDE == 1 THEN SET @row = Row(@StoreDErows, 1) SET @PickUpInstruction = Field(@row,'PickUpInstruction') SET @StoreTradingHours = Field(@row,'Trading hours') SET @StoreTradingHours = replace(replace(@StoreTradingHours ,char(13),""), char(10),"") ELSE SET @PickUpInstruction = 'Please contact the store for pickup instructions!' ENDIF
		</xsl:if>
		]%%
		<tr>
			<td align="center" valign="top" style="padding: 0px 10px;">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="width: 620px;" class="em_wrapper">
					<tr>
						<td align="center" valign="top" style="padding: 0px 53px;" class="em_aside" bgcolor="#ffffff">
							<table width="100%" border="0" cellspacing="0" cellpadding="0" class="em_wrapper">
								<tr>
									<td height="24" class="em_height">
										<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" alt="space" height="1" width="1" style="display: block;" border="0" />
									</td>
								</tr>
								<tr>
									<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; font-weight: bold; line-height: 20px; padding-bottom: 12px;">PICK-UP INFORMATION</td>
									<td width="37" class="em_side">
										<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
									</td>
									<td valign="top" align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td height="7" style="line-height: 0px;font-size: 0px;">
													<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
												</td>
											</tr>
											<tr>
												<td height="1" bgcolor="#000000" style="line-height:1px;font-size:1px;">
													<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
												</td>
											</tr>
											<tr>
												<td height="8" style="line-height: 0px;font-size: 0px;">
													<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
												</td>
											</tr>
										</table>
									</td>
								</tr>


								<tr>
									<td align="center" valign="top" style="padding-bottom: 20px;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="em_wrapper">
											<tbody>
												<tr>
													<td style="width: 10%;" valign="top" align="" width="24" class="em_full_img1">
														<img src="https://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/6f86199d-ecbb-4570-8da1-faa0f5a7cca7.png" alt="pickuplocation" width="30" class="em_img" border="0" />

													</td>
													<td width="140" class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px;font-weight:bold; color: #000000; line-height: 20px; width: 140px;">Pickup Location</td>
												</tr>
												<tr>
													<td valign="top" align="center" width="24" class="em_full_img1"></td>
													<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; font-weight: normal; line-height: 20px;">
														<strong>
															Collection Store
															<br />
															<xsl:value-of select="storeDetails/store-name" />
														</strong>
														<br />
														<xsl:value-of select="storeDetails/address-line1" />
														<br />
														<xsl:value-of select="storeDetails/suburb" />
														,
														<xsl:value-of select="storeDetails/state" />
														<xsl:value-of select="storeDetails/postcode" />
														<br />
														<a href="" class="em_black a" style="text-decoration: underline;">View Directions</a>
													</td>
												</tr>
											</tbody>
										</table>
									</td>
								</tr>
								<tr>
									<td height="8" style="line-height: 0px;font-size: 0px;">
										<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
									</td>
								</tr>
								%%[ if @donotDisplayHours == 0 then ]%%
								<tr>
									<td align="center" valign="top" style="padding-bottom: 20px;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="em_wrapper">
											<tr>
												<td valign="top" align="center" width="24" class="em_full_img1"></td>
												<td width="140" class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px;font-weight:bold; color: #000000; line-height: 20px; width: 140px;">Opening Times</td>
											</tr>
											<tr>
												<td valign="top" align="center" width="24" class="em_full_img1"></td>
												<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; font-weight: normal; line-height: 20px;">
													<table bgcolor="#CCCCCC" width="200px" border="0" align="left" cellpadding="0" cellspacing="0">
														<tr>
															<td valign="top">
																<!--

[if (gte mso 9)|(IE)]>
<table width="200px" align="left" cellpadding="0" cellspacing="0" border="0"><tr><td valign="top">
<![endif]
-->
																<table width="250px" class="maxW" style="max-width: 220px; margin: auto;" border="0" align="center" cellpadding="0" cellspacing="0">
																	<tr>
																		<td valign="top" align="left">
																			<table width="250px" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
																				<tr>
																					<td align="left">
																						<table width="250px" border="0" cellpadding="0" cellspacing="0">
																							%%[ set @debug=0 IF NOT EMPTY(@StoreTradingHours) THEN SET @tradingRows = BuildRowsetFromString(@StoreTradingHours,"^") SET @rowCount2 = RowCount(@tradingRows) FOR @i = 1 TO @rowCount2 DO SET @row1 = row(@tradingRows, @i) SET @ccDayString = field(@row1,1) SET @rowsDayString = BuildRowsetFromString(@ccDayString,"*") SET @rowCountA = RowCount(@rowsDayString)]%%
																							<tr>
																								%%[ FOR @j = 1 TO @rowCountA DO VAR @rowA, @openingDay, @openingHours , @indexA , @indexB , @indexC SET @rowA = row(@rowsDayString, 1) SET @ccDayOfWeek = field(@rowA,1) set @StoreHoursFormatted = replace(@ccDayString,'*',' ') IF NOT EMPTY(@ccDayOfWeek) THEN set @indexA=indexOf(@ccDayString,"*") set @indexB=Subtract(@indexA,1) set @indexC=Add(@indexA,1) set @openingDay = Substring(@ccDayString,1,@indexB) set @openingHours = Substring(@ccDayString,@indexC,length(@ccDayString)) ENDIF IF @j==1 THEN ]%%
																								<td valign="top" width="10%" align="left" style="color:#000000;padding-top:0px;font-family:Arial,Helvetica,sans-serif;font-size: 14px;">%%=v(@openingDay)=%%</td>
																								%%[ ELSE ]%%
																								<td valign="top" width="90%" align="right" style="color:#000000;font-family:Arial,Helvetica,sans-serif;font-size: 14px;">%%=v(@openingHours)=%%</td>
																								%%[ ENDIF NEXT @j ]%%
																							</tr>
																							%%[ NEXT @i ENDIF /* DEBUGGING VARIABLES */ if @debug == 1 then Output(Concat('warning1: ', @StoreTradingHours)) Output(Concat('warning2: ', @tradingRows)) endif ]%%
																						</table>
																					</td>
																				</tr>
																			</table>
																		</td>
																	</tr>
																</table>
																<!--

[if (gte mso 9)|(IE)]>
</td></tr></table>
<![endif]
-->
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								%%[endif]%%
								<tr>
									<td align="center" valign="top" style="padding-bottom: 20px;">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="em_wrapper">
											<tbody>
												<tr>
													<td style="width: 10%;" valign="top" align="" width="24" class="em_full_img1">
														<img src="https://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/689a3138-fde4-433a-b0c8-e52b2e73b7c8.png" alt="pickuplocation" width="30" class="em_img" border="0" />
													</td>
													<td width="140" class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px;font-weight:bold; color: #000000; line-height: 20px; width: 140px;">Nominated Collection</td>
												</tr>
												<tr>
													<td valign="top" align="center" width="24" class="em_full_img1"></td>
													<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px;">
If you've nominated someone else to collect your order,please let them know they'll need to present this email and their photo ID in-store.
</td>
												</tr>

											</tbody>
										</table>
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<!--     //PICK-UP_INFO     -->
	</xsl:template>
	<!--     Order total calculation block     -->
	<xsl:template match="message/additional-content/order/order-change/Order-Change-totals">
		<tr>
			<td align="center" valign="top">
				<table align="center" class="em_main_table" bgcolor="#f7f7f7" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed; width: 640px;">
					<tbody>
						<tr>
							<td height="30" class="em_height" style="line-height: 0px; font-size: 0px;">
								<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
							</td>
						</tr>
						<tr>
							<td valign="top" align="center" class="em_aside" style="padding-left: 222px; padding-right: 63px;">
								<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tbody>
										<tr>
											<td valign="top" align="center">
												<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody>
														<tr>
															<td class="em_grey" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; line-height: 18px; color: #1d1d1d;">
																SUB TOTAL
																<br />
																<span style="font-size: 14px;">(inc GST)</span>
																<xsl:choose>
																	<xsl:when test="//message/additional-content/order/order-change/items/item[fulfillment-method='SHP']">
																		<xsl:for-each select="//message/additional-content/order/order-change/OrderCharges/Charge">
																			<br />
																			<xsl:value-of select="Type" />
																		</xsl:for-each>
																		<xsl:if test="//message/additional-content/order/order-change/OrderDiscounts/discounts/amount!=''">
																			<xsl:for-each select="//message/additional-content/order/order-change/OrderDiscounts/discounts">
																				<br />
																				<span style="color:red">
																					%%=Replace(Replace('
																					<xsl:value-of select="Type" />
																					','_',' '), 'CARRIER', 'DELIVERY')=%%
																				</span>
																			</xsl:for-each>
																		</xsl:if>
																	</xsl:when>
																	<xsl:otherwise>
																		<br />
																		CLICK &amp; COLLECT
																	</xsl:otherwise>
																</xsl:choose>
															</td>
															<td>
																<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
															</td>
															<td class="em_grey" valign="top" align="right" style="font-family: Arial, sans-serif; font-size: 14px; line-height: 18px; color: #1d1d1d; font-weight: bold;">
																<!--     SUB_TOTAL_PRICE     -->
																$
																<xsl:value-of select="subtotal" />
																<br />
																($
																<xsl:value-of select="total-gst" />
																)
																<!--     DELIVERY PRICE     -->
																<xsl:choose>
																	<xsl:when test="//message/additional-content/order/order-change/items/item[fulfillment-method='SHP']">
																		<xsl:for-each select="//message/additional-content/order/order-change/OrderCharges/Charge">
																			<br />
																			$
																			<xsl:value-of select="amount" />
																		</xsl:for-each>
																		<xsl:if test="//message/additional-content/order/order-change/OrderDiscounts/discounts/amount!=''">
																			<xsl:for-each select="//message/additional-content/order/order-change/OrderDiscounts/discounts">
																				<br />
																				<span style="color:red">
																					-$
																					<xsl:value-of select="amount" />
																				</span>
																			</xsl:for-each>
																		</xsl:if>
																	</xsl:when>
																	<xsl:otherwise>
																		<br />
																		FREE
																	</xsl:otherwise>
																</xsl:choose>
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>

										<tr>
											<td height="10" style="line-height: 0px; font-size: 0px;">
												<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
											</td>
										</tr>
										<tr>
											<td valign="top" align="center">
												<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
													<tbody>
														<tr>
															<td class="em_grey" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 18px; line-height: 19px; color: #1d1d1d;">
																<strong>TOTAL</strong>


															</td>
															<td>
																<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
															</td>
															<td class="em_grey" valign="top" align="right" style="font-family: Arial, sans-serif; font-size: 18px; line-height: 19px; color: #1d1d1d;">
																<strong>
																	$
																	<xsl:value-of select="Grand-total" />
																</strong>

																<br />
																<br />
															</td>
															<br />
														</tr>
														<br />

													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td></td>
										</tr>
										<tr>
											<td></td>
										</tr>
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td valign="top" align="center" style="padding:0px 63px;" class="em_aside">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
									<tr>
										<td height="20" style="line-height: 0px; font-size: 0px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
									<tr>
										<td height="10" style="line-height: 0px; font-size: 0px; border-bottom: 1px dashed #878787;padding-left: 63px; padding-right: 63px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
									<tr>
										<td height="40" style="line-height: 0px; font-size: 0px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
									<tr>

										<td class="em_grey em_aside" style="font-family: Arial, sans-serif; font-size: 10px; line-height: 10px;padding-left: 63px; padding-right: 63px;">
Please be aware that some items, including those marked for clearance aren't eligible for change of mind return or exchange.
</td>
									</tr>
									<tr>
										<td height="40" style="line-height: 0px; font-size: 0px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>


	</xsl:template>
	<!--     Order total calculation block     -->
	<xsl:template match="message/additional-content/order">
		%%[ SET @date = "
		<xsl:value-of select="date" />
		" SET @FormatDate = Format(SystemDateToLocalDate(@date), "dddd dd MMM yyyy") ]%%
		<tr>
			<td align="center" valign="top">
				<table align="center" class="em_main_table" width="640" border="0" cellspacing="0" cellpadding="0" style="table-layout: fixed; width: 640px;" bgcolor="#e6e6e6">
					<tbody>
						<tr>
							<td valign="top" align="center" bgcolor="#ffffff">
								<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
									<tr>
										<td height="20" style="line-height: 0px; font-size: 0px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
									<tr>
										<td class="em_black em_aside1" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; padding-left: 63px; padding-right: 3px; line-height: 18px; padding-bottom: 12px; font-weight: 300; letter-spacing: 2px;">YOUR PAYMENT SUMMARY</td>
										<td valign="top" align="center">
											<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
												<tr>
													<td height="7" style="line-height: 0px;font-size: 0px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
												<tr>
													<td height="1" bgcolor="#000000" style="line-height:1px;font-size:1px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
												<tr>
													<td height="8" style="line-height: 0px;font-size: 0px;">
														<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/spacer.gif" height="1" width="1" alt="" style="display:block;border:none;" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td valign="top" align="center" style="padding: 0px 63px;" class="em_aside">

											<table align="left" width="240" border="0" cellspacing="0" cellpadding="0" style="width: 240px;" class="em_wrapper">
												<tr>
													<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">
														Name:
														<xsl:value-of select="//message/subscribers/subscriber/firstname" />
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td valign="top" align="center" style="padding: 0px 63px;" class="em_aside">
											<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td valign="top" align="center">
														<table align="left" width="265" border="0" cellspacing="0" cellpadding="0" style="width: 265px;" class="em_wrapper">
															<tr>
																<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">
Order date: %%=v(@FormatDate)=%%
</td>
															</tr>
														</table>
														<!--     [if gte mso 9]></td><td valign="top"><![endif]     -->
														<table align="left" width="265" border="0" cellspacing="0" cellpadding="0" style="width: 265px;" class="em_wrapper">
															<tr>

																<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">
																	Order number:
																	<xsl:value-of select="order-number" />
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<!--     Loops the payments methods     -->
									<xsl:for-each select="order-change/collection-details/collection-detail">
										<tr>
											<td valign="top" align="center" style="padding: 0px 63px;" class="em_aside">
												<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
													<tr>
														<td valign="top" align="center">
															<xsl:if test="payment-type!=''">
																<table align="left" width="240" border="0" cellspacing="0" cellpadding="0" style="width: 240px;" class="em_wrapper">
																	%%[ SET @PymtTp = '
																	<xsl:value-of select="payment-type" />
																	' SET @PymtVia = '
																	<xsl:value-of select="paid-via" />
																	'
SET @Payment = IIF((@PymtTp=='PAYPAL'), 'PayPal', IIF((@PymtTp=='AFTERPAY'),'Afterpay', IIF((@PymtTp=='MYER_VISA'),'Myer Visa', IIF((@PymtTp=='MYERV BLACKH'),'Myer Black', IIF((@PymtTp=='MYERV LOYALTY'),'Myer Loyalty', IIF((@PymtTp=='MYERV GIFT'), 'Myer Gift Card', IIF((@PymtTp=='MYERV RETURN'), 'Myer Return', IIF((@PymtTp=='MYER_CARD'), 'Myer Card', IIF((@PymtTp=='POS_CREDIT_CARD'), 'Credit Card (POS)', IIF((@PymtTp=='POS_GIFTRETURN_CARD'), 'Myer Return (POS)', IIF((@PymtTp=='POS_CASH'), 'Cash (POS)', IIF((@PymtTp=='CREDIT_CARD'), 'Credit Card', IIF((@PymtTp=='POS_DEBIT_CARD'), 'Debit Card (POS)', IIF((@PymtTp=='POS_MYER_REWD_CARD'), 'Myer Reward Card', IIF((@PymtTp=='POS_MYER_CARD'), 'Myer Card (POS)', IIF((@PymtTp=='POS_MYER_VISA'), 'Myer Card (POS)', IIF((@PymtTp=='POS_CBA_LOYALTY'), 'CBA Loyalty (POS)', IIF((@PymtTp=='MYERV MULTI'), 'Myer Multi', IIF((@PymtTp=='HUMM'),'HUMM', IIF((@PymtTp=='POS_MYER_VISA_INTFRE'), 'Myer Visa (POS)', IIF((@PymtTp=='MYERV XMAS'), 'Myer Xmas',IIF((@PymtTp=='CommAwards'), 'CommBank Awards',IIF((@PymtTp=='Velocity'), 'Velocity Points',Replace(@PymtTp, '_', ' ')))) )))))))))))))))))))) ]%%
																	<tr>
																		<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">Payment type: %%=v(@Payment)=%%</td>
																	</tr>
																	<xsl:if test="paid-via!=''">
																		<tr>
																			<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">Paid via: %%=v(@PymtVia)=%%</td>
																		</tr>
																	</xsl:if>
																</table>
															</xsl:if>
															<xsl:if test="card-number!=''">
																<xsl:if test="payment-type!='MYER_CARD'">
																	<!--     [if gte mso 9]></td><td valign="top"><![endif]     -->
																	<table align="left" width="265" border="0" cellspacing="0" cellpadding="0" style="width: 265px;" class="em_wrapper">
																		<tr>
																			<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">
																				Card number:
																				<xsl:value-of select="card-number" />
																			</td>
																		</tr>
																	</table>
																</xsl:if>
															</xsl:if>
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</xsl:for-each>
									<tr>
										<td valign="top" align="center" style="padding: 0px 63px;" class="em_aside">
											<table align="center" width="100%" border="0" cellspacing="0" cellpadding="0">
												<tr>
													<td valign="top" align="center">
														<table align="left" width="314" border="0" cellspacing="0" cellpadding="0" style="width: 314px;" class="em_wrapper">
															<tr>
																<td class="em_black" valign="top" align="left" style="font-family: Arial, sans-serif; font-size: 14px; color: #000000; line-height: 20px; padding-bottom: 12px;">
																	Email:
																	<a href="mailto:%%emailaddr%%" style="text-decoration:none !important;color:#000000 !important;font-size:normal;">
																		<span style="text-decoration:none !important;color:#000000 !important;">%%emailaddr%%</span>
																	</a>
																</td>
															</tr>
														</table>
													</td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="20" style="line-height: 0px; font-size: 0px;">
											<img src="http://image.email.myerone.com.au/lib/fe9713737563057f71/m/1/1503390624690_spacer.gif" alt="space" width="1" height="1" border="0" style="display: block;" />
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</tbody>
				</table>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>