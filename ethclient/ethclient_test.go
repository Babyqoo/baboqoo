// Copyright 2016 The go-baboqoo Authors
// This file is part of the go-baboqoo library.
//
// The go-baboqoo library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-baboqoo library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-baboqoo library. If not, see <http://www.gnu.org/licenses/>.

package ethclient

import "github.com/baboqoo/go-baboqoo"

// Verify that Client implements the baboqoo interfaces.
var (
	_ = baboqoo.ChainReader(&Client{})
	_ = baboqoo.TransactionReader(&Client{})
	_ = baboqoo.ChainStateReader(&Client{})
	_ = baboqoo.ChainSyncReader(&Client{})
	_ = baboqoo.ContractCaller(&Client{})
	_ = baboqoo.GasEstimator(&Client{})
	_ = baboqoo.GasPricer(&Client{})
	_ = baboqoo.LogFilterer(&Client{})
	_ = baboqoo.PendingStateReader(&Client{})
	// _ = baboqoo.PendingStateEventer(&Client{})
	_ = baboqoo.PendingContractCaller(&Client{})
)
