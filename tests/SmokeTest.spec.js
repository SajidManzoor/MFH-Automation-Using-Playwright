import { test, expect } from '@playwright/test';
import { Orders } from '../Orders/AllOrdersTab';


test.describe.serial('Test Suite with General Order Flow', () => {

  test.setTimeout(180000);

  let orders;
 
  test('All Orders tab Functionality Test', async ({ page }) => {

    orders = new Orders(page);

    await orders.gotoKitsPage();
    await orders.openOrdersMenu();
    await orders.verifyOrdersTabsVisible();
    await orders.gotoAllorders();
    await orders.searchAndVerifyOrder();
    await orders.verifyAllColumnsVisible();
    await orders.testAllColumnToggles();
    await orders.refreshOrdersFromShopify();
  });

 




});



