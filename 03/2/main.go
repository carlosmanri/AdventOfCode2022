package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
	"unicode"
)

func main() {
	rucksacks, _ := readLines("input.txt")

	var badges []rune
	for i := 0; i < len(rucksacks); i += 3 {
		badges = append(badges, getBadge(rucksacks[i], rucksacks[i+1], rucksacks[i+2]))
	}

	fmt.Println("Sum of all badge item priorities", sumPriorities(toPriorities(badges)))
}

func sumPriorities(priorities []int) int {
	arrSum := 0
	for i := 0; i < len(priorities); i++ {
		arrSum = arrSum + priorities[i]
	}
	return arrSum
}

func toPriorities(items []rune) []int {
	var res []int
	for _, item := range items {
		if unicode.IsLower(item) {
			res = append(res, int(item)-96)
		} else {
			res = append(res, int(item)-38)
		}
	}
	return res
}

func getBadge(rucksack1, rucksack2, rucksack3 string) rune {

	var commonItems12 string
	var commonItems23 string

	commonItems12 = getCommonRunes(rucksack1, rucksack2)
	commonItems23 = getCommonRunes(rucksack2, rucksack3)

	for _, item := range commonItems12 {
		if strings.Contains(commonItems23, string(item)) {
			return item
		}
	}
	return ' ' //Never reached by problem definition
}

func getCommonRunes(s1, s2 string) string {
	var commonItems string
	for _, item := range s1 {
		if strings.Contains(s2, string(item)) && !strings.Contains(commonItems, string(item)) {
			commonItems = commonItems + string(item)
		}
	}
	return commonItems
}

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}
